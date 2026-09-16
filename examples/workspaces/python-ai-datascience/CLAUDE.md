# AI & Data Science Engineering Workspace

## Tech Stack
- Python 3.11+ (Strict type hints)
- PyTorch, Hugging Face Transformers, LangChain / LlamaIndex
- Pandas, Polars, NumPy
- Ruff (Linter/Formatter), Pytest, Mypy

## Engineering Standards
- All model inputs/outputs must be strictly typed using Pydantic or TypedDict.
- Validate tensor shapes explicitly with assertions at module boundaries.
- Benchmark token costs and latency for all LLM calls.
- Write deterministic unit tests with mocked LLM responses.

## Harness Tools
- Use `@output-evaluator` for LLM-as-a-judge quality reviews.
- Auto-format with `ruff` via PostToolUse hooks.
