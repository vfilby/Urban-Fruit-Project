# Infrastructure

## AWS Architecture (V1)

All infrastructure defined as code using **AWS CDK (TypeScript)**.

### Compute

- **API**: AWS Lambda behind API Gateway, or ECS Fargate
  - Lambda preferred for V1 (low traffic, pay-per-use, zero idle cost)
  - Migrate to Fargate if Lambda cold starts become a problem

### Data

- **Database**: RDS PostgreSQL (with PostGIS extension)
  - Smallest instance (db.t4g.micro) sufficient for V1
  - Enable automated backups
- **File Storage**: S3 bucket for photos
  - Separate prefixes for originals and thumbnails
  - CloudFront CDN in front of S3 for photo delivery
  - Lifecycle policy to move originals to Infrequent Access after 90 days

### Auth

- JWT tokens issued by the API
- Refresh token rotation
- Tokens stored in httpOnly cookies for web, Authorization header for API

### Networking

- Custom domain (urbanfruitproject.com)
- CloudFront distribution for frontend static assets
- API Gateway custom domain or CloudFront origin for API
- HTTPS everywhere (ACM certificate)

### CI/CD

- GitHub Actions
- On push to main: run tests, build, deploy to staging
- Manual promotion to production (or auto-deploy after tests pass)
- Infrastructure changes via IaC pipeline (not console clicks)

## Cost Estimate (V1, low traffic)

| Service | Estimated Monthly Cost |
|---------|----------------------|
| RDS t4g.micro | ~$15 |
| Lambda | ~$0 (free tier) |
| S3 + CloudFront | ~$1-5 |
| API Gateway | ~$0 (free tier) |
| Route 53 | ~$0.50 |
| **Total** | **~$17-21/month** |

## Environment Strategy

| Environment | Purpose |
|-------------|---------|
| `dev` | Local development (Docker Compose with Postgres + LocalStack) |
| `staging` | AWS — mirrors production, auto-deployed from main |
| `production` | AWS — manual promotion from staging |

## Tech Stack

| Layer | Technology | Rationale |
|-------|-----------|-----------|
| **Backend** | TypeScript (Node.js) | Same language as frontend and CDK, good Lambda support |
| **Frontend** | TypeScript (React) | PWA with service worker, responsive |
| **IaC** | AWS CDK (TypeScript) | Type-safe infrastructure, single language across stack |
| **Map Tiles** | OpenStreetMap + Leaflet | Free, open source, no API key or usage fees |
| **API Framework** | TBD (Express, Fastify, or Hono) | Lightweight, Lambda-compatible |

Single-language stack (TypeScript everywhere) minimizes context switching and
allows shared types between frontend, backend, and infrastructure.
