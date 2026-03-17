# Urban Fruit Project — V2 Specification

## Vision

A community platform for mapping and cataloging perennial food-producing plants
on public land. Users contribute locations (with GPS coordinates, photos, and
notes) of fruit trees, nut trees, berry bushes, edible vines, and similar
permanent plantings that anyone can harvest from.

## Core Principle

Map things that are **perennial and location-fixed**. A cherry tree in a park, a
walnut tree on a boulevard, a blueberry bush along a trail. Not mushroom patches,
not seasonal foraging spots, not private gardens.

## Target Platforms

- **Web application** — primary platform, responsive design, works on desktop and mobile browsers
- **Progressive Web App (PWA)** — installable on mobile, supports offline use for field data collection
- Native mobile apps are a future consideration, not V1 scope.

## High-Level Architecture

- **Language**: TypeScript everywhere (frontend, backend, infrastructure)
- **Frontend**: React PWA, map-centric UI using OpenStreetMap + Leaflet
- **Backend**: REST API on AWS Lambda (Node.js)
- **Database**: PostgreSQL with PostGIS (RDS)
- **File Storage**: S3 for photos, CloudFront CDN
- **Auth**: Email/password accounts with proper password hashing (JWT)
- **Infrastructure**: AWS CDK (TypeScript)
- **Deployment**: GitHub Actions CI/CD pipeline

## V1 Scope

What we're building first:

1. User accounts (register, login, profile)
2. Add/edit/view plant locations ("caches")
3. Map view — browse plants geographically
4. Photos — upload and associate with plant locations
5. Notes/log entries — community observations per location
6. Species tagging — categorize by plant type
7. Basic search — find plants by species, location, or area

What is explicitly **not** V1:

- Social features (following, notifications, activity feeds)
- Moderation tools (admin panel, flagging, review queues)
- Data import from legacy database
- Native mobile apps
- Gamification (badges, leaderboards)
- API for third-party consumers

These are all reasonable future features but are deferred to keep V1 focused.
