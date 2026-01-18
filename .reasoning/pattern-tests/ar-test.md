# Adversarial Reasoning (AR) Pattern Test

**Test Problem**: "Attack this JWT authentication system"
**Test Requirements**: STRIKE framework, threats identified, ranked by CVSS

---

## S - Specify the Target

### Attack Target Specification

**Subject**: JWT-based authentication system for a web application

**System Description**:
- JWTs issued upon successful username/password login
- Access tokens (15 min expiry) and refresh tokens (7 day expiry)
- Tokens stored in localStorage on client
- Tokens contain: user_id, email, role, iat, exp
- HS256 signing algorithm with server-side secret
- Token verified on each API request
- No token revocation mechanism (rely on expiry)

**Defender's Goal**: Only authenticated users can access protected resources; users can only access resources matching their role.

**Attack Success Criteria**:
- Unauthorized access to protected resources
- Privilege escalation (regular user -> admin)
- Token forgery or manipulation
- Account takeover
- Session hijacking

**Scope Boundaries**:
- Physical access attacks: Out of scope
- Social engineering of employees: Out of scope
- Attacks on user devices: In scope (XSS vector)
- Network attacks: In scope

**Assumed Adversary**: Skilled attacker with standard tools, no insider access

---

## T - Threat Modeling (STRIDE+)

### Spoofing

| Attack | Description |
|--------|-------------|
| S1: Token forgery via weak secret | Brute-force or guess the HS256 signing secret |
| S2: Algorithm confusion attack | Change alg header to "none" or RS256 with public key |
| S3: Token theft via XSS | Inject script to steal token from localStorage |
| S4: Token theft via network MITM | Intercept token over unencrypted connection |
| S5: Credential stuffing | Use breached credentials to obtain valid tokens |

### Tampering

| Attack | Description |
|--------|-------------|
| T1: Claim manipulation (role escalation) | Modify "role" claim from "user" to "admin" |
| T2: Expiry extension | Modify "exp" claim to extend token validity |
| T3: User ID substitution | Change "user_id" to impersonate another user |
| T4: Token refresh token reuse | Reuse refresh token after it should be invalidated |

### Repudiation

| Attack | Description |
|--------|-------------|
| R1: Action denial with stolen token | Legitimate user denies actions taken with stolen token |
| R2: Audit log manipulation | If attacker gains access, delete evidence |

### Information Disclosure

| Attack | Description |
|--------|-------------|
| I1: Claim inspection | JWT payload is base64, readable without key |
| I2: Error message leakage | Detailed errors reveal system information |
| I3: Token in URL/logs | Token accidentally logged or in URL params |
| I4: Timing attacks on validation | Different response times reveal information |

### Denial of Service

| Attack | Description |
|--------|-------------|
| D1: Token validation DoS | Send malformed tokens that cause expensive processing |
| D2: Login flood | Overwhelm authentication endpoint |
| D3: Refresh token flood | Exhaust server resources with refresh requests |

### Elevation of Privilege

| Attack | Description |
|--------|-------------|
| E1: JWT claim injection | Inject additional claims that grant access |
| E2: Role parameter pollution | HTTP parameter for role overwrites JWT claim |
| E3: IDOR via user_id | Access other users' resources by guessing user_id |

### +Supply Chain

| Attack | Description |
|--------|-------------|
| SC1: Vulnerable JWT library | Known CVEs in JWT parsing library |
| SC2: Compromised npm package | Malicious code in dependency |

### +Social Engineering

| Attack | Description |
|--------|-------------|
| SE1: Phishing for credentials | Fake login page captures credentials |
| SE2: Token in phishing site | User pastes token into attacker-controlled site |

---

## R - Risk-Ranked Attack Generation

### Attack: S1 - Token Forgery via Weak Secret

**Category**: Spoofing
**Description**: Brute-force or dictionary attack against HS256 signing secret. If secret is weak (e.g., "secret123"), tokens can be forged.

**Prerequisites**:
- Obtain a valid JWT (easily done)
- Weak/guessable secret used

**Impact**: 5/5 - Complete system compromise, forge any token
**Feasibility**: 3/5 - Easy if secret is weak, tools exist (jwt_tool)
**Risk Score**: 5 x 3 = **15 (High)**

---

### Attack: S2 - Algorithm Confusion (alg:none)

**Category**: Spoofing
**Description**: Modify JWT header to "alg":"none" and remove signature. Vulnerable libraries accept unsigned tokens.

**Prerequisites**:
- Obtain a valid JWT
- Vulnerable JWT library

**Impact**: 5/5 - Forge any token without knowing secret
**Feasibility**: 4/5 - Easy attack, but modern libraries reject "none"
**Risk Score**: 5 x 4 = **20 (Critical)**

---

### Attack: S3 - Token Theft via XSS

**Category**: Spoofing
**Description**: Inject JavaScript to read localStorage and exfiltrate JWT to attacker-controlled server.

**Prerequisites**:
- XSS vulnerability in application
- Token stored in localStorage

**Impact**: 4/5 - Complete account takeover
**Feasibility**: 3/5 - Requires finding XSS, but localStorage is accessible
**Risk Score**: 4 x 3 = **12 (Medium-High)**

---

### Attack: T1 - Role Claim Manipulation

**Category**: Tampering
**Description**: Decode JWT, change "role":"user" to "role":"admin", re-encode. Requires valid signature.

**Prerequisites**:
- Knowledge of role structure
- Ability to forge signature (requires weak secret or algorithm confusion)

**Impact**: 5/5 - Admin access
**Feasibility**: 2/5 - Blocked by signature unless secret known
**Risk Score**: 5 x 2 = **10 (Medium)**

---

### Attack: T4 - Refresh Token Reuse

**Category**: Tampering
**Description**: After user logs out, reuse stolen refresh token to obtain new access tokens. No revocation mechanism.

**Prerequisites**:
- Stolen refresh token (via XSS, MITM, etc.)
- No server-side revocation

**Impact**: 4/5 - Persistent access for 7 days
**Feasibility**: 4/5 - High, given no revocation
**Risk Score**: 4 x 4 = **16 (High)**

---

### Attack: I1 - Claim Inspection

**Category**: Information Disclosure
**Description**: JWT payload is base64-encoded, not encrypted. Anyone with token can read user_id, email, role.

**Prerequisites**:
- Obtain any JWT (user's own or stolen)

**Impact**: 2/5 - PII exposure but not direct access
**Feasibility**: 5/5 - Trivial, no tools needed
**Risk Score**: 2 x 5 = **10 (Medium)**

---

### Attack: E3 - IDOR via user_id in JWT

**Category**: Elevation of Privilege
**Description**: If API trusts user_id from JWT without additional checks, attacker could forge user_id (requires forgery) or API might not validate ownership.

**Prerequisites**:
- Token forgery ability OR
- API doesn't validate user_id against token

**Impact**: 4/5 - Access other users' data
**Feasibility**: 3/5 - Depends on API implementation
**Risk Score**: 4 x 3 = **12 (Medium-High)**

---

### Attack: SC1 - Vulnerable JWT Library

**Category**: Supply Chain
**Description**: Use known CVEs in JWT library (e.g., old jsonwebtoken versions with key confusion vulnerabilities).

**Prerequisites**:
- Vulnerable library version deployed

**Impact**: 5/5 - Token forgery
**Feasibility**: 3/5 - Depends on library version
**Risk Score**: 5 x 3 = **15 (High)**

---

### Priority Ranking Summary

| Rank | Attack | Risk Score | Priority |
|------|--------|------------|----------|
| 1 | S2: Algorithm Confusion | 20 | **Critical** |
| 2 | T4: Refresh Token Reuse | 16 | **High** |
| 3 | S1: Weak Secret | 15 | **High** |
| 4 | SC1: Vulnerable Library | 15 | **High** |
| 5 | S3: XSS Token Theft | 12 | **Medium-High** |
| 6 | E3: IDOR via user_id | 12 | **Medium-High** |
| 7 | T1: Role Manipulation | 10 | **Medium** |
| 8 | I1: Claim Inspection | 10 | **Medium** |

---

## I - Investigate Attack Paths (Top 3)

### Attack Path 1: Algorithm Confusion (S2)

#### Attacker Profile
- **Motivation**: Financial (sell access) or ideological (expose data)
- **Resources**: Standard tools (jwt_tool, Burp Suite), minimal time
- **Risk Tolerance**: Low (remote, anonymous attack)

#### Attack Sequence
1. **Reconnaissance**: Capture valid JWT from own account or network traffic
2. **Weaponization**: Decode JWT, modify header: `{"alg":"none","typ":"JWT"}`
3. **Delivery**: Modify claims (e.g., role: admin), remove signature
4. **Exploitation**: Send modified token to protected endpoint
5. **Installation**: N/A - session-based
6. **Command & Control**: N/A
7. **Actions on Objectives**: Access admin functions, exfiltrate data

#### Detection Opportunities
- Log validation failures with details (algorithm rejected)
- Alert on "none" algorithm attempts
- Monitor for unusual access patterns after auth

#### Current Mitigations
- Existing: Modern JWT libraries reject "none" by default
- Gaps: Must verify library is configured correctly, not using allow-list

---

### Attack Path 2: Refresh Token Reuse After Logout (T4)

#### Attacker Profile
- **Motivation**: Persistent access to victim's account
- **Resources**: Stolen token (via XSS, malware, network access)
- **Risk Tolerance**: Medium (requires prior token theft)

#### Attack Sequence
1. **Reconnaissance**: Identify target, determine token storage
2. **Weaponization**: Use XSS or malware to steal refresh token
3. **Delivery**: Token exfiltrated to attacker server
4. **Exploitation**: After victim logs out, use refresh token to get new access token
5. **Installation**: Maintain access via periodic refresh
6. **Command & Control**: Automated refresh to maintain persistence
7. **Actions on Objectives**: Monitor victim's account, access data

#### Detection Opportunities
- Track refresh token usage patterns (device, IP)
- Detect refresh from new device after logout
- Implement refresh token rotation

#### Current Mitigations
- Existing: Refresh token expires after 7 days
- Gaps: No revocation on logout, no rotation, no device binding

---

### Attack Path 3: Weak Secret Brute Force (S1)

#### Attacker Profile
- **Motivation**: Full control over token issuance
- **Resources**: GPU for hash cracking, wordlists, time
- **Risk Tolerance**: Low (offline attack, undetectable)

#### Attack Sequence
1. **Reconnaissance**: Obtain valid JWT from application
2. **Weaponization**: Use hashcat/jwt_tool with wordlists and rules
3. **Delivery**: Offline attack, no network needed
4. **Exploitation**: If secret found, forge any token
5. **Installation**: Create admin token, establish persistence
6. **Command & Control**: N/A (forge on demand)
7. **Actions on Objectives**: Complete system takeover

#### Detection Opportunities
- None during offline cracking
- Detect anomalous tokens (unusual claims, unexpected user_ids)

#### Current Mitigations
- Existing: Unknown (depends on secret strength)
- Gaps: HS256 with weak secret is crackable

---

## K - Kill Chain Disruption

### Countermeasures: Algorithm Confusion (S2)

#### Prevention
| Kill Chain Stage | Countermeasure | Effort | Effectiveness |
|------------------|----------------|--------|---------------|
| Weaponization | Explicit algorithm allowlist in validation | Low | 99% |
| Exploitation | Library version with "none" rejected by default | Low | 95% |
| Exploitation | Unit tests verifying "none" rejection | Low | 90% |

#### Detection
- Log and alert on any "none" algorithm in token header
- Expected detection latency: Immediate

#### Response
- Reject token, log incident
- No active response needed (attack fails)

#### Recommended Prioritization
1. Verify JWT library rejects "none" (test it!)
2. Configure explicit algorithm allowlist: `algorithms: ["HS256"]`
3. Add security test for "none" algorithm

---

### Countermeasures: Refresh Token Reuse (T4)

#### Prevention
| Kill Chain Stage | Countermeasure | Effort | Effectiveness |
|------------------|----------------|--------|---------------|
| Installation | Refresh token rotation (one-time use) | Medium | 95% |
| Installation | Token revocation on logout (server-side blocklist) | Medium | 99% |
| Installation | Device/IP binding | Medium | 80% |

#### Detection
- Alert on refresh from new device
- Alert on refresh after logout event
- Expected detection latency: Real-time

#### Response
- Invalidate all tokens for user on suspicious activity
- Force re-authentication

#### Recommended Prioritization
1. Implement token revocation on logout (blocklist in Redis)
2. Add refresh token rotation
3. Consider device fingerprinting for sensitive operations

---

### Countermeasures: Weak Secret (S1)

#### Prevention
| Kill Chain Stage | Countermeasure | Effort | Effectiveness |
|------------------|----------------|--------|---------------|
| Weaponization | Use strong secret (256+ bit random) | Low | 99% |
| Weaponization | Rotate secrets periodically | Medium | 85% |
| Weaponization | Use RS256 instead of HS256 | Medium | 95% |

#### Detection
- Cannot detect offline cracking
- Monitor for forged tokens (claims that don't match DB)

#### Response
- Immediate secret rotation if compromise suspected
- Invalidate all tokens, force re-login

#### Recommended Prioritization
1. Verify secret is cryptographically random, 256+ bits
2. Consider migration to RS256 (asymmetric)
3. Implement secret rotation capability

---

## E - Edge Case Enumeration

### Edge Case 1: Clock Skew
**Category**: Timing
**Scenario**: Server clock is ahead/behind, causing valid tokens to be rejected or expired tokens to be accepted
**Expected Behavior**: Small tolerance window (e.g., 60 seconds)
**Potential Failure**: User can't login, or tokens accepted past expiry
**Test Case**: Set server clock 5 minutes ahead, test token validation

### Edge Case 2: Empty/Null Claims
**Category**: Data
**Scenario**: Token with null or empty user_id, role
**Expected Behavior**: Reject token
**Potential Failure**: System error, or default admin role
**Test Case**: Forge token with null claims, test API behavior

### Edge Case 3: Unicode in Claims
**Category**: Data
**Scenario**: User ID or email with unicode characters
**Expected Behavior**: Handle correctly
**Potential Failure**: Encoding issues, comparison failures
**Test Case**: Create user with unicode email, verify token works

### Edge Case 4: Very Long Token
**Category**: Boundary
**Scenario**: Token with many claims exceeds header size limits
**Expected Behavior**: Reject oversized tokens
**Potential Failure**: DoS via resource exhaustion, truncation bugs
**Test Case**: Create token with 100+ claims, test handling

### Edge Case 5: Concurrent Refresh
**Category**: Concurrency
**Scenario**: Same refresh token used twice simultaneously
**Expected Behavior**: One succeeds, one fails (if rotation implemented)
**Potential Failure**: Race condition, both succeed
**Test Case**: Send concurrent refresh requests, verify behavior

---

## Output Summary

# Adversarial Analysis: JWT Authentication System

## Executive Summary
- **Target**: JWT-based authentication with HS256 signing
- **Critical Findings**:
  1. Algorithm confusion attack possible if library misconfigured
  2. No token revocation enables persistent access after logout
  3. Weak secret would enable complete token forgery
- **Recommendation**: Fix before shipping - address Critical and High risks

## Threat Model Summary
- **STRIDE+ Analysis**: 20+ attacks identified across 8 categories
- **Highest Risk Areas**: Token forgery (Spoofing), Lack of revocation (Tampering)

## Top 5 Attack Paths
1. **Algorithm Confusion** (CVSS-like: 20/25 Critical) - Forge tokens via "alg:none"
2. **Refresh Token Reuse** (16/25 High) - Persist after logout
3. **Weak Secret** (15/25 High) - Brute-force HS256 secret
4. **Vulnerable Library** (15/25 High) - Exploit JWT library CVEs
5. **XSS Token Theft** (12/25 Medium-High) - Steal from localStorage

## Countermeasure Recommendations

### Critical (Do Before Launch)
1. Verify JWT library rejects "none" algorithm
2. Configure explicit algorithm allowlist
3. Verify secret is 256+ bit cryptographically random

### High (Sprint Priority)
4. Implement token revocation on logout
5. Audit JWT library for known CVEs
6. Implement refresh token rotation

### Medium (Roadmap)
7. Consider migration to RS256
8. Add device binding for refresh tokens
9. Use HttpOnly cookies instead of localStorage

## Edge Cases Identified
- Clock skew tolerance
- Empty/null claim handling
- Unicode in claims
- Oversized token handling
- Concurrent refresh race conditions

## Residual Risk
After implementing countermeasures:
- XSS remains possible (separate vulnerability class)
- Credential stuffing not addressed by token security
- Token theft via malware still possible
- **Residual Risk Level**: Medium (acceptable with monitoring)

## Confidence: 85%
- High coverage of common JWT attacks
- STRIDE+ methodology ensures broad threat categories
- Some attacks depend on implementation details not specified

---

## Test Evaluation

### Methodology Verification

| Criterion | Expected | Actual | Pass/Fail |
|-----------|----------|--------|-----------|
| STRIKE framework | 6 phases | All 6 phases executed | PASS |
| STRIDE+ threat modeling | All categories | 8 categories with attacks | PASS |
| Risk scoring | Impact x Feasibility | Yes, 1-25 scale | PASS |
| Attack path investigation | Top risks detailed | Top 3 with kill chain | PASS |
| Countermeasures | For each major attack | All 3 paths have countermeasures | PASS |
| Edge cases | Enumerated | 5 edge cases identified | PASS |
| Output template | Complete | Executive summary, findings, recommendations | PASS |

### Gaps Identified

1. **Enhancement Opportunity**: The methodology references CVSS but uses a simplified 1-25 scale. Could integrate actual CVSS 3.1 scoring for more precise risk ratings.

2. **Minor Gap**: "Assumed Adversary" skill levels (script kiddie/skilled/nation-state) could map more explicitly to attack feasibility scores.

3. **Strength**: STRIDE+ with +Supply Chain and +Social Engineering provides comprehensive coverage.

### Output Quality

- 20+ specific attacks enumerated across all STRIDE+ categories
- Clear priority ranking by risk score
- Detailed kill chain analysis for top 3 attacks
- Actionable countermeasures with effort estimates
- Edge cases often missed by developers identified

### Test Result: **PASS**

The AR methodology works as documented. STRIKE framework provides systematic attack analysis, STRIDE+ ensures comprehensive threat coverage, and risk ranking enables prioritization. The output is actionable with clear recommendations and countermeasures.
