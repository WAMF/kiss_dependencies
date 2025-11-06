# Claude Code Agents for Kiss Dependencies

This directory contains specialized Claude Code agents for working with the kiss_dependencies package.

## Available Agents

### kiss-dependencies-reviewer

**Purpose:** Expert reviewer for kiss_dependencies package usage in your applications.

**What it does:**
- Scans your codebase for kiss_dependencies usage
- Identifies anti-patterns and missing dependency injection opportunities
- Verifies correct usage of registration, resolution, and factory patterns
- Checks test files for proper mocking and override patterns
- Provides detailed recommendations with code examples

**When to use:**
- After integrating kiss_dependencies into an existing project
- During code reviews to ensure DI best practices
- When refactoring code to use dependency injection
- To audit an application for proper kiss_dependencies usage
- Before production releases to catch DI issues

**How to use:**

In any project that uses kiss_dependencies, invoke the agent with:

```
@kiss-dependencies-reviewer please review this codebase
```

Or for specific files/directories:

```
@kiss-dependencies-reviewer review lib/features/auth/
```

Or with specific concerns:

```
@kiss-dependencies-reviewer check if we're using lazy vs immediate registration correctly
```

**Example output:**
The agent will provide a comprehensive review including:
- Overall compliance assessment
- Critical issues that need immediate attention
- Recommended improvements for better code quality
- Suggestions for optimization
- Before/after code examples

## Creating Agents for Other Projects

To use these agents in your own projects that depend on kiss_dependencies:

1. Copy the `.claude/agents/` directory to your project
2. Commit it to your repository
3. The agents will be automatically available in Claude Code when working on that project

## Agent Development

Agent files are Markdown files with YAML frontmatter that define:
- `name`: Unique identifier for the agent
- `description`: What the agent does (shown in suggestions)
- `tools`: Which Claude Code tools the agent can use

The body contains the agent's expertise, instructions, and behavioral guidelines.
