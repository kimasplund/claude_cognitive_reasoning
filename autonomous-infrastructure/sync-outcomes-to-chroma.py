#!/usr/bin/env python3
"""
Sync skill outcomes from JSONL log to ChromaDB skill_memory collection.
Run periodically or at end of session.
"""

import json
import os
import sys
from datetime import datetime
from pathlib import Path

# Try to import chromadb
try:
    import chromadb
except ImportError:
    print("chromadb not installed. Run: pip install chromadb")
    sys.exit(1)

LOG_FILE = Path.home() / ".claude" / "logs" / "skill_outcomes.jsonl"
CHROMA_DIR = Path.home() / ".claude" / "chroma_data"
SYNCED_FILE = Path.home() / ".claude" / "logs" / "skill_outcomes_synced.txt"

def load_synced_ids():
    """Load IDs already synced to ChromaDB."""
    if SYNCED_FILE.exists():
        return set(SYNCED_FILE.read_text().strip().split('\n'))
    return set()

def save_synced_ids(ids):
    """Save synced IDs."""
    SYNCED_FILE.parent.mkdir(parents=True, exist_ok=True)
    SYNCED_FILE.write_text('\n'.join(ids))

def main():
    if not LOG_FILE.exists():
        print("No outcomes log found. Nothing to sync.")
        return

    # Connect to ChromaDB
    client = chromadb.PersistentClient(path=str(CHROMA_DIR))

    # Get or create skill_memory collection
    try:
        collection = client.get_collection("skill_memory")
    except:
        collection = client.create_collection("skill_memory")

    # Load already synced IDs
    synced_ids = load_synced_ids()

    # Read outcomes
    outcomes = []
    with open(LOG_FILE, 'r') as f:
        for line in f:
            if line.strip():
                try:
                    outcome = json.loads(line)
                    if outcome.get('id') not in synced_ids:
                        outcomes.append(outcome)
                except json.JSONDecodeError:
                    continue

    if not outcomes:
        print("No new outcomes to sync.")
        return

    # Prepare for ChromaDB
    documents = []
    ids = []
    metadatas = []

    for outcome in outcomes:
        doc = f"Task: {outcome.get('description', 'unknown')}. Type: {outcome.get('task_type', 'unknown')}. Agent/Skill: {outcome.get('agent', 'unknown')}. Success: {outcome.get('success', False)}"
        documents.append(doc)
        ids.append(outcome['id'])
        metadatas.append({
            "task_type": outcome.get('task_type', 'unknown'),
            "agent": outcome.get('agent', 'unknown'),
            "success": outcome.get('success', False),
            "timestamp": outcome.get('timestamp', datetime.now().isoformat()),
            "description": outcome.get('description', 'unknown')[:200]  # Truncate long descriptions
        })

    # Add to ChromaDB
    collection.add(
        documents=documents,
        ids=ids,
        metadatas=metadatas
    )

    # Update synced IDs
    synced_ids.update(ids)
    save_synced_ids(synced_ids)

    print(f"Synced {len(outcomes)} outcomes to ChromaDB skill_memory collection.")

if __name__ == "__main__":
    main()
