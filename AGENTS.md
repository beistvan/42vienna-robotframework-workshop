# AGENTS.md

Instructions for AI agents working with this Robot Framework workshop repository.

For full project context, see [CLAUDE.md](CLAUDE.md).

## Agent Capabilities

### Test Generation
- Generate Robot Framework test cases from natural language descriptions
- Use existing resource files from `resources/` for keyword abstraction
- Follow the page object pattern established in the project
- Target SauceDemo (https://www.saucedemo.com) with Browser Library

### PR Review
When reviewing student PRs, check:
- Tests have `[Documentation]` keyword
- Tests use resource file keywords (not raw selectors where keywords exist)
- Tests have meaningful assertions (not just navigation)
- Tests follow naming convention: `{username}_exercise_{n}.robot`
- Tests are placed in `tests/student_exercises/`

### Test Improvement
- Suggest refactoring raw selectors into resource file keywords
- Recommend data-driven approaches with `[Template]` where appropriate
- Identify flaky patterns (hard waits, fragile selectors)

## Package Management

Uses `uv` (NOT pip). Run tests with `uv run robot`, install deps with `uv sync`.

## Browser Library Patterns

```robotframework
# Browser lifecycle
New Browser    chromium    headless=${True}
New Context
New Page    https://www.saucedemo.com

# Interactions
Fill Text    id=user-name    standard_user
Click    id=login-button

# Assertions (built-in to getter keywords)
Get Title    ==    Swag Labs
Get Text    css=.title    ==    Products
Get Url    *=    /inventory.html
```
