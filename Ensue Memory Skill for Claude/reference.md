# Ensue CLI - Complete Reference

## Command Reference

### Global Options

All commands support these global options:
- `--help`: Show command-specific help
- Requires `ENSUE_TOKEN` environment variable

### Commands

#### create_memory

Create a new memory entry with optional semantic search capabilities.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory [OPTIONS]
```

**Required Options:**
- `--key-name TEXT`: Unique identifier for the memory (must be unique)
- `--description TEXT`: Human-readable description (used for search and context)
- `--value TEXT`: The data to store (MUST be base64 encoded)

**Optional Options:**
- `--embed BOOLEAN`: Generate vector embeddings for semantic search (default: false)
- `--embed-source TEXT`: Which field to embed - "description" or "value" (default: "description")

**Example:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "user/preferences" \
  --description "User coding preferences" \
  --value "$(echo 'TypeScript preferred' | base64)" \
  --embed true
```

---

#### get_memory

Retrieve a specific memory by its key name.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue get_memory --key-name TEXT
```

**Options:**
- `--key-name TEXT` (required): The key name of the memory to retrieve

**Returns:**
- Memory metadata (key, description, timestamps)
- Base64-encoded value
- Permission information

---

#### update_memory

Update the value of an existing memory.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue update_memory [OPTIONS]
```

**Options:**
- `--key-name TEXT` (required): The key of the memory to update
- `--value TEXT` (required): New value (MUST be base64 encoded)
- `--description TEXT` (optional): Updated description

**Note:** Updating a memory preserves permissions and subscriptions.

---

#### delete_memory

Permanently delete a memory.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue delete_memory --key-name TEXT
```

**Options:**
- `--key-name TEXT` (required): The key of the memory to delete

**Warning:** This operation is irreversible. All subscriptions and permissions are also deleted.

---

#### list_keys

List all memory keys with metadata.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_keys [OPTIONS]
```

**Options:**
- `--limit INTEGER`: Maximum number of keys to return (default: 100)
- `--offset INTEGER`: Pagination offset (default: 0)

**Returns:**
For each memory:
- Key name
- Description
- Size (in bytes)
- Created timestamp
- Updated timestamp
- Permission level

---

#### search_memories

Search for memories using semantic similarity.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories [OPTIONS]
```

**Options:**
- `--query TEXT` (required): Natural language search query
- `--limit INTEGER`: Maximum results to return (default: 10, max: 100)

**Returns:**
- Matching memories ranked by relevance score
- Only returns memories you have read permission for
- Includes key, description, and similarity score

**Note:** Only searches memories that have embeddings enabled (`--embed true`).

---

#### discover_memories

Discover memory keys using semantic similarity on key names.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue discover_memories --query TEXT
```

**Options:**
- `--query TEXT` (required): Search query for discovering related keys

**Use Case:** Find related memories when you don't remember exact key names.

---

#### share

Manage users, groups, and permissions for memories.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue share [OPTIONS]
```

**Permission Levels:**
- `read`: Can read the memory
- `write`: Can read and update the memory
- `admin`: Can read, update, delete, and manage permissions

**Common Options:**
- `--key-name TEXT`: Memory to share
- `--user TEXT`: Username to grant access
- `--group TEXT`: Group name to grant access
- `--permission TEXT`: Permission level (read/write/admin)

---

#### subscribe_to_memory

Subscribe to notifications for changes to a memory.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue subscribe_to_memory --key-name TEXT
```

**Options:**
- `--key-name TEXT` (required): Memory key to subscribe to

**Notifications sent when:**
- Memory value is updated
- Memory is deleted
- Permissions are changed

---

#### unsubscribe_from_memory

Unsubscribe from notifications for a memory.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue unsubscribe_from_memory --key-name TEXT
```

**Options:**
- `--key-name TEXT` (required): Memory key to unsubscribe from

---

#### list_subscriptions

List all active memory subscriptions.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_subscriptions
```

**Returns:**
- List of all memories you're subscribed to
- Subscription timestamps
- Memory metadata

---

#### list_permissions

List all permissions that apply to the current user.

**Usage:**
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_permissions
```

**Returns:**
- All memories you have access to
- Your permission level for each
- Whether access is direct or via group

---

## Environment Variables

### ENSUE_TOKEN

**Required:** Yes

**Description:** Authentication token for the Ensue Memory Network.

**Setup:**
```bash
# Set for current session
export ENSUE_TOKEN=your_token_here

# Or add to ~/.bashrc or ~/.zshrc
echo 'export ENSUE_TOKEN=your_token_here' >> ~/.bashrc

# Or use inline
ENSUE_TOKEN=your_token ensue [command]
```

**Security Note:** Keep your token secure. Don't commit it to version control.

---

## Data Format Requirements

### Base64 Encoding

All memory values MUST be base64 encoded.

**Encoding:**
```bash
# Linux/macOS
echo "your text" | base64

# Encoding from file
cat file.txt | base64

# Encoding JSON
echo '{"key": "value"}' | base64
```

**Decoding:**
```bash
# Linux/macOS
echo "encoded_string" | base64 -d

# Save decoded output
echo "encoded_string" | base64 -d > output.txt
```

### Key Naming Conventions

**Best Practices:**
- Use forward slashes for hierarchy: `project/feature/detail`
- Use underscores for multi-word names: `user_preferences`
- Keep keys descriptive but concise
- Use consistent prefixes: `user/`, `team/`, `project/`

**Examples:**
- `user/coding_style`
- `project/myapp/current_sprint`
- `team/guidelines/code_review`
- `lessons/bug_fixes/auth_2024_12`

---

## Error Codes

### Common Errors

**ENSUE_TOKEN environment variable required**
- Cause: Token not set
- Solution: Set `ENSUE_TOKEN` environment variable

**Memory key already exists**
- Cause: Trying to create a memory with existing key
- Solution: Use `update_memory` or choose different key

**Memory not found**
- Cause: Key doesn't exist or no permission
- Solution: Verify key with `list_keys`

**Permission denied**
- Cause: Insufficient permissions for operation
- Solution: Check permissions with `list_permissions`

**Invalid base64**
- Cause: Value not properly base64 encoded
- Solution: Encode value before submitting

---

## Performance Considerations

### Embedding Generation

- Embeddings enable semantic search but add processing time
- Use `--embed true` only for memories you'll search semantically
- Choose `--embed-source` wisely:
  - `description`: Faster, good for most cases
  - `value`: Slower, use when value contains searchable content

### Search Optimization

- Use smaller `--limit` values for faster searches
- Be specific in search queries for better results
- Consider using `discover_memories` for key-based discovery

### Pagination

- Use `--limit` and `--offset` for large result sets
- Default limit is usually sufficient (100 for list_keys)

---

## Security Best Practices

1. **Token Management**
   - Never commit tokens to version control
   - Use environment variables or secure secret management
   - Rotate tokens periodically

2. **Permission Model**
   - Grant minimum required permissions
   - Use groups for team access management
   - Audit permissions regularly with `list_permissions`

3. **Data Sensitivity**
   - Don't store sensitive credentials in memories
   - Consider encryption for highly sensitive data
   - Use appropriate permission levels

4. **Cleanup**
   - Delete memories containing temporary data
   - Unsubscribe from notifications you don't need
   - Review and revoke unnecessary permissions

---

## Integration Patterns

### With CI/CD

```bash
# Store build metadata
BUILD_INFO=$(echo "{\"version\": \"1.2.3\", \"commit\": \"abc123\"}" | base64)
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "builds/production/latest" \
  --description "Latest production build information" \
  --value "$BUILD_INFO"
```

### With Scripts

```bash
#!/bin/bash
# Store script execution results

RESULT=$(./my-script.sh 2>&1)
ENCODED=$(echo "$RESULT" | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "scripts/my_script/last_run" \
  --description "Last execution of my-script.sh" \
  --value "$ENCODED"
```

### With Development Workflow

```bash
# Start of day: Review context
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories --query "what did I work on yesterday" --limit 5

# During work: Store progress
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue update_memory \
  --key-name "session/current" \
  --value "$(echo 'Working on feature X' | base64)"

# End of day: Save state
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "session/2024_12_14" \
  --description "Work completed on Dec 14" \
  --value "$(echo 'Completed auth refactor, started testing' | base64)"
```

---

## Version and Help

### Version Information

```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue --version
```

### Command Help

```bash
# General help
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue --help

# Command-specific help
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory --help
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories --help
```

---

## Limits and Quotas

Refer to your Ensue account settings for:
- Maximum number of memories
- Maximum memory size
- Rate limits
- Search query limits
- Embedding quotas

---

## Support and Resources

- Documentation: https://www.ensue-network.ai/docs
- CLI Installation: `uvx --from ensue-cli ensue`
- GitHub Issues: Check ensue-cli repository
