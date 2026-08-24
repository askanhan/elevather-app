-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.549589
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: A Brief Use of AI: What You Can Actually Do With It
-- ============================================

-- Category: Digital Skills & AI Literacy
-- Check/Create category 'Digital Skills & AI Literacy'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Digital Skills & AI Literacy', 'test description', '2026-08-23 19:54:06.547674');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Digital Skills & AI Literacy'), 30, 'A Brief Use of AI: What You Can Actually Do With It', 'Understand what AI is genuinely good at, where it fails, and how to use it as a capability multiplier in daily life without losing your own voice or judgement.', 'Women learners (18+), beginners welcome — no technical background required', 18, '2026-08-23 19:54:06.547682');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It'), 1, 'AI is not the future. It is a tool already in your hand.', 'What do you currently believe about AI, and where did that belief come from?', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('AI is not the future. It is a tool already in your hand.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'AI is not the future. It is a tool already in your hand.' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Most conversations about AI sit at two extremes: it will solve everything, or it will ruin everything. Neither of those helps you make dinner, write a difficult email, or finish a project. The useful truth is quieter: AI is a tool — the same way a calculator, a search engine, or a spreadsheet is a tool. It is powerful, it has real limits, and you can learn to use it well in about an afternoon.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'AI is not the future. It is a tool already in your hand.' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('You don’t need to understand how an engine works to drive a car. You just need to know where you’re going.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'AI is not the future. It is a tool already in your hand.' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('There is also a quieter pattern worth naming: women are statistically less likely to adopt new AI tools early — not because of ability, but because of confidence and ‘I am not technical enough’ beliefs. This matters. AI literacy is becoming a baseline skill in most fields, the same way email was in the 1990s. The women who learn to use it well, early, will have a quiet but real advantage over the next ten years.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'AI is not the future. It is a tool already in your hand.' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_subtitle (content) VALUES ('What do you currently believe about AI, and where did that belief come from?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'AI is not the future. It is a tool already in your hand.' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Name one thing you’ve been hesitant to try with AI because it felt ‘too technical’ or ‘not for you’. Don’t solve it yet — just name it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'AI is not the future. It is a tool already in your hand.' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Keep that thing in mind. By the end of this course, you’ll know how to try it — safely and on your terms.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'AI is not the future. It is a tool already in your hand.' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It'), 2, 'What AI is actually good at', 'Six things AI genuinely does well', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('What AI is actually good at');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is actually good at' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Before deciding where to use AI, it helps to know what it does well. The short version: it is excellent at language-based tasks — reading, writing, explaining, reformatting, translating, summarising. It is good at helping you start when you are stuck, and at turning a messy thought into a cleaner sentence. It is not a search engine, not a calculator, not a therapist — and treating it as any of those will lead to disappointment.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is actually good at' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Six things AI genuinely does well');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is actually good at' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_quote (content, author) VALUES ('AI is not here to replace your thinking. It is here to handle the typing.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is actually good at' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_text (content) VALUES ('Notice the pattern: AI is at its best when you already have a rough idea and need help shaping it. It is at its worst when you have no idea and hope it will have one for you. This is why the best users of AI are not the most technical people — they are the people with the clearest thoughts.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is actually good at' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_open_questions (question) VALUES ('Which of the six tasks above would save you the most time this month if you started using AI for it?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is actually good at' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_last_messages (content) VALUES ('AI makes a fast second pair of hands. You are still the one holding the direction.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is actually good at' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It'), 3, 'What AI is bad at — and how to catch it', 'A 3-step verification habit', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('What AI is bad at — and how to catch it');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is bad at — and how to catch it' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Here is something that should be taught in the first ten minutes of using any AI, and almost never is: AI can be confidently wrong. It can invent facts, misquote sources, get dates and numbers wrong, and present all of it in a polished, convincing tone. This is called hallucination, and it happens to every AI model, every day. It does not mean the tool is broken. It means you have to stay in the driver’s seat.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is bad at — and how to catch it' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_quote (content, author) VALUES ('AI is confident by default. That does not make it correct.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is bad at — and how to catch it' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_subtitle (content) VALUES ('The five most common things AI gets wrong');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is bad at — and how to catch it' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_subtitle (content) VALUES ('A 3-step verification habit');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is bad at — and how to catch it' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_mcq (question) VALUES ('You ask an AI a question about Belgian tax rules and it gives you a confident, detailed answer. What do you do next?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You ask an AI a question about Belgian tax rules and it gives you a confident, detailed answer. What do you do next?' ORDER BY id DESC LIMIT 1), 'Trust it — the answer sounded professional and specific.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You ask an AI a question about Belgian tax rules and it gives you a confident, detailed answer. What do you do next?' ORDER BY id DESC LIMIT 1), 'Use it as a starting point, then verify the key facts on the official FPS Finance / SPF Finances site or with an accountant.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You ask an AI a question about Belgian tax rules and it gives you a confident, detailed answer. What do you do next?' ORDER BY id DESC LIMIT 1), 'Keep asking the AI the same question in different ways until one answer feels right.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is bad at — and how to catch it' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Have you ever trusted an answer from an AI (or any technology) that later turned out to be wrong? What would you check differently next time?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is bad at — and how to catch it' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_last_messages (content) VALUES ('AI is a junior colleague who never admits when they’re unsure. You are the senior one — stay in that role.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What AI is bad at — and how to catch it' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It'), 4, 'Practical uses: specific things to try this week', 'For learning anything new', NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Practical uses: specific things to try this week');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Theory is fine, but AI only becomes useful once you’ve actually typed something into it. Here are concrete examples across work, home, career and learning — with the kind of short, clear prompts that actually work. Copy them, change the details, and try one today.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_subtitle (content) VALUES ('At work');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_subtitle (content) VALUES ('At home & for career');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_subtitle (content) VALUES ('For learning anything new');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_quote (content, author) VALUES ('The first prompt is never the best one. The second prompt — where you correct the first answer — is usually where AI becomes useful.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'quote', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_mcq (question) VALUES ('You ask AI to help draft an email and the first answer is too formal and not quite ‘you’. What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You ask AI to help draft an email and the first answer is too formal and not quite ‘you’. What do you do?' ORDER BY id DESC LIMIT 1), 'Give up and write the whole thing yourself, frustrated.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You ask AI to help draft an email and the first answer is too formal and not quite ‘you’. What do you do?' ORDER BY id DESC LIMIT 1), 'Say: ‘This is too formal. Rewrite it warmer, shorter, in my voice. Keep the main points.’');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You ask AI to help draft an email and the first answer is too formal and not quite ‘you’. What do you do?' ORDER BY id DESC LIMIT 1), 'Post it anyway, even though it doesn’t sound like you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Pick ONE of the prompts above that fits something you actually need this week. Write down the real version (with your details) — but don’t run it yet. Just write it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'open question', 8, LAST_INSERT_ID());

-- Component 9 for Card 4
INSERT INTO component_last_messages (content) VALUES ('AI gets better the second time you ask. Don’t give up on the first answer — shape it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Practical uses: specific things to try this week' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It'), 5, 'Healthy boundaries with AI', 'Four boundaries worth keeping', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Healthy boundaries with AI');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Healthy boundaries with AI' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('AI is not dangerous, but it can quietly shift your habits if you let it. The goal is not to use it less — it is to use it consciously. There are four small boundaries that keep AI a tool in your hand instead of becoming a hand you’ve handed over. None of this is about fear. It is about staying the author of your own life while using a very capable assistant.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Healthy boundaries with AI' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_subtitle (content) VALUES ('Four boundaries worth keeping');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Healthy boundaries with AI' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_quote (content, author) VALUES ('A good AI user leaves every conversation still sounding like herself.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Healthy boundaries with AI' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_text (content) VALUES ('The emotional boundary is worth spending a line on. AI can feel patient, non-judgmental and always available — qualities real relationships don’t always have. That can make it tempting to process everything there first. But AI cannot actually remember you the way a friend does, cannot call you back, cannot notice you have been quiet for a week. If something is weighing on you, use AI to help you find words — and then take those words to a person who loves you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Healthy boundaries with AI' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_mcq (question) VALUES ('You’re about to share a long, personal message about a difficult situation with an AI chatbot to get advice. What’s the healthiest first move?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re about to share a long, personal message about a difficult situation with an AI chatbot to get advice. What’s the healthiest first move?' ORDER BY id DESC LIMIT 1), 'Share everything including names and sensitive details — it feels anonymous so it’s fine.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re about to share a long, personal message about a difficult situation with an AI chatbot to get advice. What’s the healthiest first move?' ORDER BY id DESC LIMIT 1), 'Write it first in your own words, then share a version without identifying details. Use AI to help you organise your thinking — then take the real version to a person you trust.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re about to share a long, personal message about a difficult situation with an AI chatbot to get advice. What’s the healthiest first move?' ORDER BY id DESC LIMIT 1), 'Don’t share anything — AI is never useful for emotional things.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Healthy boundaries with AI' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Of the four boundaries above, which one do you want to hold most carefully? Write one sentence about why.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Healthy boundaries with AI' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 5
INSERT INTO component_last_messages (content) VALUES ('You are not less capable for using AI. You are less capable only if you stop thinking, writing, and deciding for yourself.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Healthy boundaries with AI' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It'), 6, 'Your AI toolkit — and a small experiment', 'What you now know', NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Your AI toolkit — and a small experiment');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your AI toolkit — and a small experiment' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('You’ve reached the end of Elevather’s course journey. You built tools for self-confidence, motivation, networking, partnering, thankfulness — and now, a way to multiply all of them using technology that was science fiction ten years ago. The point is not to become an AI expert. The point is to stop being afraid of it, and to start using it as a capable, imperfect assistant in service of the life you are actually building.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your AI toolkit — and a small experiment' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_subtitle (content) VALUES ('What you now know');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your AI toolkit — and a small experiment' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_quote (content, author) VALUES ('The women who will use AI best are not the most technical. They are the ones with the clearest thoughts and the strongest standards.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your AI toolkit — and a small experiment' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_mcq (question) VALUES ('Pick the small experiment you want to try this week.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the small experiment you want to try this week.' ORDER BY id DESC LIMIT 1), 'Use AI to draft one difficult email I’ve been postponing — then edit it into my own voice.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the small experiment you want to try this week.' ORDER BY id DESC LIMIT 1), 'Ask AI to explain one topic I’ve been avoiding — then quiz me on it.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the small experiment you want to try this week.' ORDER BY id DESC LIMIT 1), 'Run one of the prompts from Card 4 on something real in my work or life this week.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your AI toolkit — and a small experiment' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write one sentence: ‘This week, I will try [the specific experiment] by [when and where]’. Keep it small enough to actually do.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your AI toolkit — and a small experiment' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_last_messages (content) VALUES ('You don’t need permission to use AI. You don’t need a technical background. You just need to start — and stay yourself while doing it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your AI toolkit — and a small experiment' AND owner_id = (SELECT id FROM module WHERE title = 'A Brief Use of AI: What You Can Actually Do With It') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
