# Ensue Memory Skill for Claude

A Claude skill for interacting with the Ensue Memory Network - a distributed memory system with semantic search and collaboration features.

## What This Skill Does

This skill teaches Claude how to use Ensue's memory operations:
- Store and retrieve data with unique keys
- Search memories using natural language (semantic search)
- Share memories with other users and groups
- Subscribe to memory changes
- Manage permissions for collaborative workflows

## Installation

To get started, add to the folder `.claude/skills/ensue-memory/` so that it will be automatically discovered by Claude.

### Prerequisites

1. **Ensue CLI**: Install using uvx
   ```bash
   uvx --from ensue-cli ensue
   ```

2. **ENSUE_TOKEN**: Set your authentication token
   ```bash
   export ENSUE_TOKEN=your_token_here
   ```

   Add to your shell profile for persistence:
   ```bash
   echo 'export ENSUE_TOKEN=your_token_here' >> ~/.bashrc  # or ~/.zshrc
   ```

## Files

- **SKILL.md**: Main skill documentation and instructions for Claude
- **reference.md**: Complete CLI command reference
- **examples.md**: Practical examples and use cases
- **scripts/encode-helper.sh**: Helper script for base64 encoding/decoding

## Quick Start

### Testing the Skill

```bash
# List available memories
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_keys

# Create a test memory
VALUE=$(echo "This is a test memory" | base64)
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "test/hello" \
  --description "Test memory for skill verification" \
  --value "$VALUE"

# Search for it
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories \
  --query "test memory" \
  --limit 5

# Retrieve it
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue get_memory --key-name "test/hello"

# Clean up
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue delete_memory --key-name "test/hello"
```

## Using the Helper Script

The `encode-helper.sh` script simplifies base64 encoding:

```bash
# Encode text
./scripts/encode-helper.sh encode "Hello, World!"

# Decode base64
./scripts/encode-helper.sh decode "SGVsbG8sIFdvcmxkIQo="
```

## When This Skill Activates

This skill activates when you explicitly request memory operations:
- "Search my memories for..."
- "Create a memory about..."
- "Remember this..."
- "What's in my memories?"
- "List my memories"
- "Share this memory with..."

## What You Can Do With Ensue

### Store Any Data
Save text, JSON, code snippets, or any information with semantic search.

### Search Semantically
Find memories using natural language queries instead of exact key names.

### Collaborate
Share memories with team members and subscribe to changes.

### Organize Flexibly
Use hierarchical key names to organize your data however you prefer.

### Manage Permissions
Control who can read, write, or manage your memories.

## Key Concepts

### Memory Keys
Use hierarchical naming:
- `user/coding_style`
- `project/myapp/current_sprint`
- `team/guidelines`
- `lessons/bug_fixes`

### Semantic Search
Memories with `--embed true` can be found using natural language:
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories --query "what are my TypeScript preferences"
```

### Base64 Encoding
All values must be base64 encoded:
```bash
echo "your content" | base64
```

## Troubleshooting

**"ENSUE_TOKEN environment variable required"**
- Set the token: `export ENSUE_TOKEN=your_token`

**"Memory key already exists"**
- Use `update_memory` instead of `create_memory`
- Or choose a different key name

**"Permission denied"**
- Check permissions: `ensue list_permissions`
- Verify you own the memory or have been granted access

## Documentation

- **SKILL.md**: Complete skill instructions
- **reference.md**: Detailed CLI reference
- **examples.md**: 10+ practical examples
- **Official docs**: https://www.ensue-network.ai/docs

## Development

To modify this skill:
1. Edit `SKILL.md` for Claude's instructions
2. Update `reference.md` for CLI documentation
3. Add examples to `examples.md`
4. Test with Claude to ensure proper invocation

## Security

- Never commit your `ENSUE_TOKEN` to version control
- Use environment variables or secure secret managers
- Grant minimum required permissions
- Review permissions regularly with `ensue list_permissions`

## Version

This skill is compatible with:
- Claude Code (all versions)
- Ensue CLI (latest version via uvx)

## Support

For issues:
- Ensue CLI: https://www.ensue-network.ai/docs
- Claude Skills: https://code.claude.com/docs/en/skills
