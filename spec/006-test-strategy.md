# Test Strategy

## Guiding Principle

Tests are part of the specification. They define what the system does, not how.
When code is regenerated, all tests must still pass. This means:

- **Tests describe behavior, not implementation**
- Tests are written against the API contract and UI behavior
- No mocking of core domain logic — test the real thing
- Database tests hit a real PostgreSQL instance

## Test Layers

### 1. API Contract Tests (highest priority)

Test every API endpoint against the spec in `004-api.md`.

For each endpoint, verify:
- Correct HTTP status codes for success and error cases
- Response body shape matches documented schema
- Authentication requirements enforced
- Authorization rules enforced (owner-only edits, etc.)
- Pagination works correctly
- Spatial queries return correct results

**Tools**: Language-appropriate HTTP testing (supertest, httpx, etc.) against a running API with a real database.

### 2. Domain Logic Tests

Test business rules that aren't fully captured by API tests:
- Password hashing produces valid hashes and verifies correctly
- JWT token creation and validation
- Photo resize/thumbnail generation produces correct dimensions
- Spatial bounding box queries include/exclude correct points
- Species hierarchy traversal

### 3. Frontend Integration Tests

Test the PWA user experience:
- Map loads and displays markers
- User can complete registration → login → add location flow
- Offline form submission queues correctly and syncs
- Photo upload from camera works
- Search returns and displays results

**Tools**: Playwright or Cypress against a running frontend + API.

### 4. Infrastructure Tests

Verify IaC produces correct resources:
- Database is accessible with PostGIS enabled
- S3 bucket exists with correct permissions
- Lambda/API Gateway routes to the API
- CloudFront serves frontend assets
- HTTPS works on custom domain

**Tools**: IaC framework's built-in testing (CDK assertions, Terraform plan validation).

## What We Don't Test

- CSS styling / visual appearance (manual review)
- Third-party service internals (S3 upload works = AWS's problem)
- Performance (deferred to when we have real traffic)

## Test Data

- Seed script creates a standard set of species
- Test fixtures include known lat/lng points for spatial query testing
- Photo tests use small test images (not real photos)

## CI Requirements

All tests must pass before merge to main. Test suite should run in under 5 minutes.
