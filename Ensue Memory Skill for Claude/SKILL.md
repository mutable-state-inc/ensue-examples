---
name: ensue-memory
description: Interact with the Ensue memory network for storing and retrieving persistent data. Use when the user explicitly requests memory operations like "search my memories", "create a memory", "remember this", or "what's in my memories".
---

# Ensue Memory Network

Ensue is a distributed memory network for AI agents that allows you to persist and retrieve information using semantic search and collaboration features.

## Overview

Ensue Memory enables you to:
- Store and retrieve any type of data with unique keys
- Search memories using semantic similarity (natural language queries)
- Share memories with other users and groups
- Subscribe to memory changes for notifications
- Manage permissions for collaborative workflows

## Authentication

All Ensue commands require the `ENSUE_TOKEN` environment variable to be set:

```bash
export ENSUE_TOKEN=your_token_here
```

Or prefix commands with the token:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue [command]
```

## Core Commands

### Create Memory

Store new information with semantic search capabilities:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "user_preferences" \
  --description "User coding preferences and style guidelines" \
  --value "$(echo 'User prefers TypeScript over JavaScript' | base64)" \
  --embed true \
  --embed-source "description"
```

**Important:** The `--value` field MUST be base64 encoded.

**Options:**
- `--key-name TEXT` (required): Unique identifier for the memory
- `--description TEXT` (required): Human-readable description for search
- `--value TEXT` (required): Base64-encoded data to store
- `--embed BOOLEAN`: Enable vector embeddings for semantic search (default: false)
- `--embed-source TEXT`: Field to embed - "description" or "value" (default: "description")

### Search Memories

Find memories using natural language queries:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories \
  --query "what are the user's TypeScript preferences" \
  --limit 10
```

Returns results ranked by semantic similarity.

**Options:**
- `--query TEXT` (required): Natural language search query
- `--limit INTEGER`: Max results to return (default: 10, max: 100)

### Get Memory

Retrieve a specific memory by key:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue get_memory --key-name "user_preferences"
```

### Update Memory

Modify an existing memory:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue update_memory \
  --key-name "user_preferences" \
  --value "$(echo 'Updated preferences' | base64)"
```

**Note:** Value must be base64 encoded.

### Delete Memory

Remove a memory permanently:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue delete_memory --key-name "old_preference"
```

### List Keys

Browse all available memories with metadata:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_keys --limit 100 --offset 0
```

Shows description, size, and timestamps for each memory.

**Options:**
- `--limit INTEGER`: Max keys to return (default: 100)
- `--offset INTEGER`: Pagination offset (default: 0)

### Discover Memories

Find related memories using semantic discovery:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue discover_memories --query "coding patterns"
```

## Collaboration Features

### Share Memories

Manage permissions for users and groups:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue share [OPTIONS]
```

Control who can read, write, or manage your memories.

### Subscribe to Changes

Get notifications when memories are updated:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue subscribe_to_memory --key-name "shared_guidelines"
```

### Unsubscribe

Stop receiving notifications:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue unsubscribe_from_memory --key-name "shared_guidelines"
```

### List Subscriptions

View your active subscriptions:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_subscriptions
```

### List Permissions

Check permissions for the current user:

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_permissions
```

## Common Use Cases

### 1. Storing Data

```bash
# Store any data with semantic search enabled
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "my_data" \
  --description "Description of what this data contains" \
  --value "$(echo 'Your data here' | base64)" \
  --embed true
```

### 2. Searching Memories

```bash
# Find memories using natural language
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories \
  --query "your search query here" \
  --limit 5
```

### 3. Retrieving Specific Memories

```bash
# Get a memory by its key
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue get_memory --key-name "my_data"
```

### 4. Updating Existing Memories

```bash
# Update a memory's value
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue update_memory \
  --key-name "my_data" \
  --value "$(echo 'Updated data' | base64)"
```

### 5. Listing Available Memories

```bash
# Browse all your memories
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_keys --limit 100
```

## Tips and Best Practices

1. **Use Descriptive Keys**: Choose meaningful, hierarchical key names like `project_name/feature/detail`

2. **Enable Embeddings**: Set `--embed true` for memories you'll search semantically

3. **Good Descriptions**: Write clear descriptions that capture the essence of the memory

4. **Base64 Encoding**: Always encode values before storing:
   ```bash
   echo "your content" | base64
   ```

5. **Organize with Namespaces**: Use prefixes like `user/`, `project/`, `team/` for organization

6. **Regular Cleanup**: Delete outdated memories to keep the network relevant

7. **Search First**: Before creating, search to avoid duplicates

8. **Collaborative Workflows**: Use sharing and subscriptions for team coordination

## Installation

Install the Ensue CLI using uvx:

```bash
uvx --from ensue-cli ensue
```

## Version Information

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue --version
```

## Getting Help

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue --help                    # General help
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue [command] --help          # Command-specific help
```

## Error Handling

- **Missing Token**: Ensure `ENSUE_TOKEN` is set in your environment
- **Invalid Base64**: Verify your value is properly base64 encoded
- **Permission Denied**: Check your permissions with `list_permissions`
- **Key Not Found**: Use `list_keys` to verify the key exists

## When to Use This Skill

Use this skill when the user explicitly requests memory operations:
- "Search my memories for..."
- "Create a memory about..."
- "Remember this..."
- "What's stored in my memories?"
- "Save this to memory"
- "Find memories about..."
- "Share this memory with..."
- "List my memories"

This is a general-purpose tool for interacting with the Ensue memory network. Users can organize and use their memories however they prefer.
