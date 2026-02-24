# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Project Overview

Robot Framework E2E testing workshop for 42 Vienna. Tests target [SauceDemo](https://www.saucedemo.com), a demo e-commerce site. Uses Browser Library (Playwright-based) for browser automation.

## Package Management

This project uses **uv** (NOT pip). All dependency management goes through `pyproject.toml` and `uv.lock`.

```bash
uv sync                              # Install all dependencies into .venv/
uv sync --locked                     # Install with exact lockfile versions
uv run robot tests/                  # Run tests via the project's venv
uv run rfbrowser init chromium       # Initialize Playwright Chromium browser
uv add <package>                     # Add a new dependency
uv add --group dev <package>         # Add a dev dependency
```

Do NOT use `pip install`, `pip freeze`, or `requirements.txt`.

## Repository Structure

```
tests/
├── 00_setup_verification/    # Smoke test — run first
├── 01_first_test/            # Intro test with comments
├── 02_login_tests/           # Login page tests
├── 03_product_tests/         # Product catalog tests
├── 04_cart_tests/            # Shopping cart tests
├── 05_checkout_tests/        # Checkout flow tests
├── 06_e2e_scenarios/         # Full purchase flow
└── student_exercises/        # Student-created tests go here

resources/
├── common.resource           # Shared setup/teardown, base URL, credentials
├── saucedemo.resource        # Convenience import for all page resources
├── login_page.resource       # Login page keywords
├── products_page.resource    # Products/inventory page keywords
├── cart_page.resource        # Shopping cart keywords
└── checkout_page.resource    # Checkout flow keywords

scripts/
└── check_environment.py      # Environment readiness checker (stdlib only)
```

## Robot Framework Conventions

- **Separator:** Use 4 spaces between keyword and arguments (2+ spaces required)
- **Naming:** Keywords use Title Case (`Login With Credentials`), variables use `${UPPER_CASE}`
- **Resource files:** One per page (page object pattern). Import via `Resource` in Settings.
- **Tags:** Use `student` and `exercise` for student-created tests
- **Documentation:** Every test case and keyword should have `[Documentation]`

## SauceDemo Reference

**URL:** https://www.saucedemo.com

**Test Users:**
| Username | Behavior |
|----------|----------|
| `standard_user` | Normal user (primary test account) |
| `locked_out_user` | Always locked out |
| `problem_user` | Has UI bugs |
| `performance_glitch_user` | Slow responses |
| `error_user` | Returns errors |
| `visual_user` | Visual differences |

**Password (all users):** `secret_sauce`

**Key CSS Selectors:**
- Login: `id=user-name`, `id=password`, `id=login-button`, `.error-message-container`
- Products: `.inventory_item`, `.inventory_item_name`, `.inventory_item_price`, `.shopping_cart_badge`, `.product_sort_container`
- Cart: `.cart_item`, `id=checkout`, `id=continue-shopping`
- Checkout: `id=first-name`, `id=last-name`, `id=postal-code`, `id=continue`, `id=finish`, `.complete-header`

## Common Commands

```bash
# Run all tests
uv run robot tests/

# Run specific suite
uv run robot tests/02_login_tests/

# Run student exercises only
uv run robot tests/student_exercises/

# Run with visible browser (not headless)
uv run robot --variable HEADLESS:false tests/00_setup_verification/

# Check environment
python scripts/check_environment.py

# Initialize browsers
uv run rfbrowser init chromium
```

## Test Writing Guidelines

When generating tests for this project:
1. Import `../../resources/common.resource` for setup/teardown
2. Use keywords from page-specific resource files
3. Add `[Documentation]` to every test case
4. Add `[Tags]    student    exercise` for student tests
5. Use `Suite Setup` / `Suite Teardown` for browser lifecycle
6. Place student tests in `tests/student_exercises/` with pattern `{name}_exercise_{n}.robot`
