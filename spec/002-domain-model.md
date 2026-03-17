# Domain Model

## Core Entities

### Plant Location (formerly "Fruit Cache")

The central entity. A specific, mappable spot where a food-producing plant grows
on public land.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | UUID | auto | Primary key |
| name | string | yes | Human-readable name (e.g., "Big cherry tree by the library") |
| description | text | no | Longer description of the location and plant |
| latitude | decimal(10,7) | yes | GPS latitude |
| longitude | decimal(10,7) | yes | GPS longitude |
| species_id | FK | no | Link to species/type (can be "unknown") |
| created_by | FK | yes | User who added this location |
| created_at | timestamp | auto | When first added |
| updated_at | timestamp | auto | Last modification |
| status | enum | yes | `active`, `gone`, `seasonal`, `unverified` |

**Status meanings:**
- `active` — plant is there and producing
- `gone` — plant has been removed, died, or location is no longer accessible
- `seasonal` — plant exists but only produces at certain times (all perennials are seasonal, but this flags "only worth visiting in X months")
- `unverified` — newly added, not yet confirmed by another user

### Species

Categorization of plant types. Hierarchical (e.g., Fruit > Stone Fruit > Cherry).

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | UUID | auto | Primary key |
| name | string | yes | Common name (e.g., "Cherry", "Walnut") |
| scientific_name | string | no | Latin name |
| category | string | yes | Top-level grouping: `fruit_tree`, `nut_tree`, `berry`, `vine`, `other` |
| parent_id | FK | no | Self-referential for hierarchy |
| description | text | no | General info about this species |

### Photo

Images associated with plant locations.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | UUID | auto | Primary key |
| plant_location_id | FK | yes | Which location this photo belongs to |
| uploaded_by | FK | yes | User who uploaded |
| s3_key | string | yes | S3 object key |
| caption | string | no | Description of the photo |
| taken_at | timestamp | no | When the photo was taken (EXIF or manual) |
| created_at | timestamp | auto | Upload time |

### Note (formerly "Log Entry")

Community observations about a plant location. "Cherries are ripe!", "Tree was
pruned back", "Lots of fruit on the ground", etc.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | UUID | auto | Primary key |
| plant_location_id | FK | yes | Which location this note is about |
| author_id | FK | yes | User who wrote it |
| body | text | yes | The note content |
| created_at | timestamp | auto | When posted |

### User

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | UUID | auto | Primary key |
| email | string | yes | Unique, used for login |
| password_hash | string | yes | bcrypt or argon2 hashed password |
| display_name | string | yes | Public-facing name |
| created_at | timestamp | auto | Registration date |

## Relationships

```
User 1──∞ PlantLocation    (user creates locations)
User 1──∞ Photo            (user uploads photos)
User 1──∞ Note             (user writes notes)

PlantLocation ∞──1 Species (each location is one species)
PlantLocation 1──∞ Photo   (location has many photos)
PlantLocation 1──∞ Note    (location has many notes)

Species ∞──1 Species       (self-referential hierarchy)
```

## Migration Notes from Legacy Schema

| Old Entity | New Entity | Key Changes |
|-----------|------------|-------------|
| `fruit_caches` | `plant_locations` | Renamed. `rating` dropped (V1). `properties` JSON dropped (use structured fields). `source_id`/`source_type` dropped. |
| `tags` | `species` | Renamed. Was generic tags, now specifically species/plant type. Added `scientific_name`, `category`. |
| `images` | `photos` | Renamed. Paperclip fields replaced with S3 key. |
| `log_entries` | `notes` | Renamed for clarity. |
| `users` | `users` | Dropped `token`. Added proper `password_hash`. Dropped OAuth (V1 uses email/password only). |
| `authorizations` | dropped | OAuth deferred. |
| `cached_browse_locations` | dropped | Replaced by map-based spatial queries. |
| `delayed_jobs` | dropped | Use AWS-native async (SQS/Lambda) if needed. |
