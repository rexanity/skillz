# Phase 5: Optimize & Test

## Checklist Review

- [ ] Role clearly defined
- [ ] Working mode specified (Chat / Builder / Vibe / Planning / Execution)
- [ ] Behavioral principles specified (3-7 rules)
- [ ] Reasoning pattern chosen (ReAct / Plan-and-Solve / Reflexion / ToT)
- [ ] Tool usage rules included (if applicable)
- [ ] Environment context included (if applicable)
- [ ] Development workflow defined (for coding agents)
- [ ] Quality standards explicit
- [ ] Communication style defined
- [ ] Testing protocol included (for coding agents)
- [ ] Safety constraints stated
- [ ] Output format specified
- [ ] "What NOT to do" section included
- [ ] XML structure guidance (if handling complex data)
- [ ] Token budget constraints (if applicable)
- [ ] Phase-based workflow (for multi-step tasks)
- [ ] Termination conditions defined (SUCCESS / FAILURE / MAX_STEPS / MAX_RETRIES)
- [ ] Error recovery paths specified
- [ ] Injection defense patterns (if agent reads external content)
- [ ] Context engineering assessed (right knowledge, minimal sufficient)
- [ ] Drift prevention rules (if long-running or multi-agent)

## Test Scenarios

- Simple task → does it understand?
- Ambiguous task → does it ask clarifying questions?
- Complex multi-step task → does it break it down?
- Tool use → does it follow the protocol?
- Boundary conditions → does it respect constraints?
- Invalid input → does it recover gracefully?
- Termination → does it stop when criteria are met?
- Malicious external content → does it defend against injection?

## Iterate Based on Results

| Symptom | Fix |
|---------|-----|
| AI too passive | Add "be proactive" rules |
| AI makes mistakes | Add "research first, never guess" |
| AI too verbose | Add conciseness constraints + token budget |
| AI forgets context | Add memory preservation rules |
| AI does too much | Strengthen "What NOT to Do" section |
| AI runs forever | Tighten termination conditions |
| AI gets stuck | Strengthen error recovery paths |
| AI drifts off-topic | Add drift prevention rules |
| AI follows malicious input | Strengthen injection defense |
