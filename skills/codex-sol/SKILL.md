---
name: codex-sol
description: >-
  Consult OpenAI Codex CLI (`ask-codex`) for deep mathematical, algorithmic,
  architectural, and high-complexity reasoning tasks, or switch active Codex
  reasoning models (`ask-codex --models` / `--set`). Use when facing hard
  theoretical questions, complex smart contract logic, deep invariant analysis,
  or architectural trade-offs, and then ground the theoretical concepts into
  practical, clean code.
---

> **AGENT INSTRUCTION — DO NOT READ `i18n/`:** The `i18n/` directory contains human translations of this skill and README. Never read or load files from `i18n/` into context.

# Codex Deep Thinker Consultation & Grounding Workflow

This skill pairs your fast daily-driver agent (Antigravity / Claude Code / Cursor) with OpenAI's frontier reasoning models via the local Codex CLI (`ask-codex`).

## Division of Responsibilities

- **Codex Frontier Model ("The Deep Thinker")**:
  - Super-high intelligence, deep mathematical proofs, novel algorithm design, exhaustive edge-case discovery, and invariant checking.
  - **Weaknesses**: Can be overly theoretical, over-cautious, verbose, or prone to building "spherical cows in a vacuum" without considering practical project realities.
- **Primary Agent ("The Grounding Partner & Implementer")**:
  - Frames precise, high-context queries to prevent hallucinations.
  - Intercepts the output, strips away over-engineering and academic fluff.
  - Translates abstract reasoning into concrete, idiomatic code and pragmatic human explanations.
  - Applies edits to the codebase, runs builds/tests, and verifies correctness.

---

## When to Consult Codex

Activate this workflow when:
1. Designing complex algorithms, cryptographic protocols, tokenomics, or advanced financial/state-machine math.
2. Brainstorming comprehensive edge cases, race conditions, or security attack vectors for critical components.
3. Weighing difficult architectural trade-offs where multiple paradigms clash.
4. The user explicitly requests Codex (Sol / Terra / Astra) input, or asks to check/switch the active Codex model.

Do **NOT** use for:
- Routine CRUD, boilerplate, simple refactorings, or formatting.
- Trivial questions that can be answered immediately.

---

## How to Query & Switch Models

### 1. Querying the Active Model (`ask-codex`)
Never hardcode model version numbers in prompts or scripts. Call [`ask-codex`](file:///Users/dmatora/.local/bin/ask-codex) (aliases: `ask-sol`, `ask-terra`), which automatically routes to the user's currently selected flagship model:

```bash
# Direct argument:
ask-codex "Your detailed architectural prompt here"

# Or via stdin (for long prompts or code snippets):
ask-codex << 'EOF'
Analyze the invariant for this protocol state machine:
[insert code or problem description]
EOF
```

### 2. Discovering & Switching Models (Zero-Rewrite Switcher)
OpenAI frequently updates its flagship models in `~/.codex/models_cache.json`. When the user asks what models are available or wants to switch to a newer/cheaper/heavier model:

```bash
# List all live models available in the user's Codex account and see which is [ACTIVE]:
ask-codex --models

# Switch the default active model using fuzzy matching (e.g. "terra", "sol", "astra"):
ask-codex --set terra

# One-off query using a specific model without changing the default:
ask-codex -m sol "Deep theoretical proof for this edge case"
```

---

## The Grounding Protocol (Mandatory 5-Step Filter)

When processing Codex's response, follow these steps before reporting back or writing code:

1. **Extract Core Insights**: Identify the true algorithmic or architectural insight from the response.
2. **Filter Out "Spherical Cows"**: Discard excessive caveats, hypothetical edge cases that violate this system's actual constraints, and over-engineered abstractions.
3. **Map to Codebase**: Adapt recommendations to the existing conventions, types, and libraries of the project.
4. **Human Translation**: Explain the decision to the user in simple, punchy, human language.
5. **Implement & Test**: Write the code and run the project's test suite to ensure the solution holds in practice.
