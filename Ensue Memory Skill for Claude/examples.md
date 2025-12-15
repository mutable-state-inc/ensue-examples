# Ensue Memory - Practical Examples

This document shows various ways to use the Ensue memory network. These are examples of what you CAN do - use them as reference when the user asks to perform memory operations.

## Example 1: Storing Structured Data

### Use Case
Storing configuration or preferences as JSON.

### Implementation
```bash
# Encode the preference data
VALUE=$(echo '{
  "indentation": "tabs",
  "tab_size": 4,
  "error_verbosity": "verbose",
  "auto_save": true
}' | base64)

# Create the memory
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "user/coding_style" \
  --description "User prefers tabs for indentation, verbose error messages, and auto-save enabled" \
  --value "$VALUE" \
  --embed true \
  --embed-source "description"
```

### Retrieval
```bash
# Search for it later
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories \
  --query "indentation preferences" \
  --limit 5

# Or get it directly by key
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue get_memory --key-name "user/coding_style"
```

## Example 2: Storing Text Content

### Use Case
Saving notes, documentation, or text-based information.

### Implementation
```bash
VALUE=$(echo 'Always use async/await in useEffect with proper cleanup. Avoid Promise chains in hooks. Example:
useEffect(() => {
  let cancelled = false;
  const fetchData = async () => {
    const result = await api.getData();
    if (!cancelled) setData(result);
  };
  fetchData();
  return () => { cancelled = true; };
}, []);' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "lessons/react_async_patterns" \
  --description "Learned pattern for proper async/await usage in React useEffect hooks with cleanup" \
  --value "$VALUE" \
  --embed true
```

### Searching
```bash
# Find it using natural language
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories \
  --query "React hooks async patterns" \
  --limit 3
```

## Example 3: Updating Memories Over Time

### Use Case
Creating a memory and updating it as information changes.

### Initial Creation
```bash
VALUE=$(echo 'Project status:
- Task 1 (DONE)
- Task 2 (IN PROGRESS)
- Task 3 (TODO)' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "project/status" \
  --description "Current project status" \
  --value "$VALUE" \
  --embed true
```

### Updating Later
```bash
VALUE=$(echo 'Project status:
- Task 1 (DONE)
- Task 2 (DONE)
- Task 3 (IN PROGRESS)' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue update_memory \
  --key-name "project/status" \
  --value "$VALUE"
```

## Example 4: Storing Multiple Related Memories

### Use Case
Organizing related information using hierarchical keys.

### Implementation
```bash
VALUE=$(echo '{
  "testing": {
    "framework": "vitest",
    "avoid": ["jest", "mocha"],
    "reason": "Vitest is faster and has better DX"
  },
  "styling": {
    "framework": "tailwind",
    "avoid": ["styled-components"],
    "reason": "Prefers utility-first CSS"
  },
  "package_manager": "pnpm"
}' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "user/tool_preferences" \
  --description "User prefers vitest for testing, tailwind for styling, pnpm for package management" \
  --value "$VALUE" \
  --embed true
```

## Example 5: Collaboration and Sharing

### Use Case
Sharing memories with team members.

### Implementation
```bash
VALUE=$(echo 'Team Coding Guidelines:
1. All PRs must have tests
2. Use conventional commits (feat:, fix:, docs:)
3. Max function length: 50 lines
4. Required code review from 2 team members
5. All async functions must have error handling
6. Use TypeScript strict mode' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "team/coding_guidelines" \
  --description "Team coding standards and PR requirements" \
  --value "$VALUE" \
  --embed true

# Share with team
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue share \
  --key-name "team/coding_guidelines" \
  --read-access "team-developers" \
  --write-access "team-leads"

# Subscribe to changes
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue subscribe_to_memory \
  --key-name "team/coding_guidelines"
```

## Example 6: Storing Code Snippets

### Use Case
Saving reusable code patterns or snippets.

### Implementation
```bash
VALUE=$(echo 'Memory leak in React app traced to:
1. Event listeners not being cleaned up in useEffect
2. setTimeout/setInterval without cleanup
3. Subscriptions to external services not unsubscribed

Solution pattern:
useEffect(() => {
  const handler = () => { /* ... */ };
  element.addEventListener("event", handler);
  return () => element.removeEventListener("event", handler);
}, []);

Always check Chrome DevTools Memory profiler for detached DOM nodes.' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "debugging/react_memory_leaks" \
  --description "Common patterns for React memory leaks and how to fix them with useEffect cleanup" \
  --value "$VALUE" \
  --embed true
```

## Example 7: Storing Documentation

### Use Case
Saving documentation, standards, or reference information.

### Implementation
```bash
VALUE=$(echo 'API Design Standards:
- REST endpoints use noun-based URLs: /users, /posts
- Always return consistent error format:
  {
    "error": {
      "code": "ERROR_CODE",
      "message": "Human readable message",
      "details": {}
    }
  }
- Use HTTP status codes correctly:
  * 200: Success
  * 201: Created
  * 400: Bad request
  * 401: Unauthorized
  * 403: Forbidden
  * 404: Not found
  * 500: Server error
- All dates in ISO 8601 format
- Pagination: ?limit=20&offset=0
- Versioning: /api/v1/resource' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "project/api_conventions" \
  --description "REST API design standards including error formats, status codes, and URL conventions" \
  --value "$VALUE" \
  --embed true
```

## Example 8: Creating and Retrieving Session State

### Use Case
Saving work-in-progress information.

### Saving State
```bash
VALUE=$(echo 'Working on: User profile page redesign
Status: 60% complete
Completed:
- Created new ProfileCard component
- Implemented responsive layout
- Added avatar upload functionality
TODO:
- Add form validation
- Implement save button with API integration
- Add loading states
- Write unit tests
Blockers:
- Waiting for API endpoint /users/:id/profile to be deployed
Current branch: feature/profile-redesign
Open files: ProfileCard.tsx, ProfileForm.tsx' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "session/current_task" \
  --description "Current work on user profile page redesign - 60% complete" \
  --value "$VALUE" \
  --embed true
```

### Retrieving Later
```bash
# Get the saved state
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue get_memory --key-name "session/current_task"

# Or search for it
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories \
  --query "profile page work" \
  --limit 5
```

## Example 9: Organizing with Namespaces

### Use Case
Using key prefixes to organize memories by category.

### Implementation
```bash
# Project A context
VALUE_A=$(echo 'E-commerce platform - checkout flow optimization' | base64)
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "project/ecommerce/current_focus" \
  --description "Optimizing checkout flow for better conversion rates" \
  --value "$VALUE_A" \
  --embed true

# Project B context
VALUE_B=$(echo 'Admin dashboard - adding analytics widgets' | base64)
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "project/admin_dashboard/current_focus" \
  --description "Building new analytics widgets for admin dashboard" \
  --value "$VALUE_B" \
  --embed true

# List all projects
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_keys --limit 100 | grep "project/"
```

## Example 10: Listing and Browsing Memories

### Use Case
Viewing all available memories and filtering by pattern.

### List All Memories
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_keys --limit 100
```

### Filter by Searching Keys
```bash
# List keys related to a project
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue list_keys | grep "project/"
```

## Example 11: Deleting Memories

### Use Case
Removing outdated or unnecessary memories.

### Implementation
```bash
# Delete a specific memory
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue delete_memory --key-name "old_data"
```

## Example 12: Storing and Retrieving Code

### Store a code snippet
```bash
VALUE=$(echo 'import { useState, useEffect } from "react";

export function useFetch<T>(url: string) {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    let cancelled = false;
    fetch(url)
      .then(res => res.json())
      .then(data => {
        if (!cancelled) {
          setData(data);
          setLoading(false);
        }
      })
      .catch(err => {
        if (!cancelled) {
          setError(err);
          setLoading(false);
        }
      });
    return () => { cancelled = true; };
  }, [url]);

  return { data, loading, error };
}' | base64)

ENSUE_TOKEN=your_token uvx --from ensue-cli ensue create_memory \
  --key-name "snippets/react_use_fetch_hook" \
  --description "Custom React hook for fetching data with loading and error states" \
  --value "$VALUE" \
  --embed true
```

### Retrieve the snippet
```bash
ENSUE_TOKEN=your_token uvx --from ensue-cli ensue search_memories \
  --query "React custom hook for API calls" \
  --limit 3
```

## Best Practices

1. **Hierarchical Keys**: Use prefixes like `user/`, `project/`, `team/` for organization
2. **Descriptive Names**: Make key names meaningful and memorable
3. **Rich Descriptions**: Write searchable descriptions for better semantic search
4. **Enable Embeddings**: Use `--embed true` for memories you'll search with natural language
5. **Update vs Create**: Use `update_memory` to modify existing memories instead of creating duplicates
6. **Regular Cleanup**: Delete outdated memories to keep the network relevant
7. **JSON for Structure**: Store structured data as JSON for easy parsing
8. **Consistent Naming**: Establish key naming conventions for your use case
