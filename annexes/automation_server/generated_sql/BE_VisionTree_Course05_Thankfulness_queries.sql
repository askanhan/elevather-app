-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.561448
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Thankfulness: The Quiet Psychological Relief
-- ============================================

-- Category: Connection & Community
-- Check/Create category 'Connection & Community'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Connection & Community', 'test description', '2026-08-23 19:54:06.559874');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Connection & Community'), 22, 'Thankfulness: The Quiet Psychological Relief', 'Learn thankfulness as a psychological practice — not forced positivity — that helps you see what you have, resist comparison, and stay grounded even on hard days.', 'Women learners (18+)', 15, '2026-08-23 19:54:06.559882');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief'), 1, 'Thankfulness is not a performance. It is a kind of attention.', 'What does the word ‘thankfulness’ honestly bring up for you?', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Thankfulness is not a performance. It is a kind of attention.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness is not a performance. It is a kind of attention.' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Thankfulness has a PR problem. It sounds like something you post on Instagram — ‘blessed’, ‘grateful’, pretty coffee in the morning light. That version is exhausting, and most women can feel the difference between real gratitude and performed gratitude from a distance. This course is about the real one.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness is not a performance. It is a kind of attention.' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('Thankfulness is not optimism. It is noticing what’s already here.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness is not a performance. It is a kind of attention.' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('In clinical psychology, thankfulness is understood as a form of attention — the trained habit of noticing what is already present in your life, rather than what is missing or what others have. Research by Robert Emmons and others has shown consistent links between this practice and lower anxiety, better sleep, and higher life satisfaction. It is not magic. It is a small daily shift in where your attention lands.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness is not a performance. It is a kind of attention.' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_subtitle (content) VALUES ('What does the word ‘thankfulness’ honestly bring up for you?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness is not a performance. It is a kind of attention.' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Name one thing in your life right now that you take almost completely for granted. It can be small. (A body that works, a person who calls, a safe home, a window with light.) Write it down.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness is not a performance. It is a kind of attention.' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_last_messages (content) VALUES ('You just practiced the core skill of this course. That was it. The rest is how to do it on purpose.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness is not a performance. It is a kind of attention.' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief'), 2, 'The comparison trap: why you can’t feel what you already have', 'A small practice — the ‘one year ago’ question', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('The comparison trap: why you can’t feel what you already have');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Here is the hard truth: most of us don’t fail at thankfulness because we have little. We fail because we are constantly measuring our lives against someone else’s. Social comparison theory (Festinger, 1954) showed decades ago that humans evaluate themselves by looking at people slightly above them. Social media made this accidental habit into a full-time job. Every time you compare upward, your brain quietly downgrades what you already have.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_quote (content, author) VALUES ('You cannot appreciate your own life while you are measuring it against someone else’s highlight reel.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Two kinds of comparison — only one helps');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_text (content) VALUES ('This reframe matters clinically. Women who compare mainly to their own past selves show significantly higher life satisfaction than women who compare mainly to peers, even when the two groups have similar objective lives. The same life, two different stories, because of where the eyes are pointed.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_subtitle (content) VALUES ('A small practice — the ‘one year ago’ question');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'subtitle', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_mcq (question) VALUES ('You open Instagram and immediately see three posts of people seemingly doing better than you. You notice your mood drop. What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You open Instagram and immediately see three posts of people seemingly doing better than you. You notice your mood drop. What do you do?' ORDER BY id DESC LIMIT 1), 'Keep scrolling to find something that makes you feel better by comparison.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You open Instagram and immediately see three posts of people seemingly doing better than you. You notice your mood drop. What do you do?' ORDER BY id DESC LIMIT 1), 'Close the app, and ask yourself: ‘compared to me a year ago, what has changed for the better?’');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You open Instagram and immediately see three posts of people seemingly doing better than you. You notice your mood drop. What do you do?' ORDER BY id DESC LIMIT 1), 'Post something impressive so other women feel the same way looking at you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_open_questions (question) VALUES ('Answer the three ‘one year ago’ questions above. Be specific. Small changes count.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'open question', 8, LAST_INSERT_ID());

-- Component 9 for Card 2
INSERT INTO component_last_messages (content) VALUES ('You are not in a race with the woman on your screen. You are only ever in conversation with the woman you were last year.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The comparison trap: why you can’t feel what you already have' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief'), 3, 'Celebrate yourself on the way up — not only at the top', 'How to actually do it (a 30-second practice)', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Celebrate yourself on the way up — not only at the top');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Celebrate yourself on the way up — not only at the top' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Many women have a specific pattern: they delay celebration until ‘the big thing’ happens. The promotion, the degree, the first €10k month, the book being finished. The problem is that once the big thing arrives, the goalpost moves. A new bigger thing replaces it, and the old achievement suddenly feels small. You spend an entire life chasing and never arriving.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Celebrate yourself on the way up — not only at the top' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_quote (content, author) VALUES ('If you don’t cheer for yourself at each step, you won’t cheer for yourself at the top. The goalpost always moves.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Celebrate yourself on the way up — not only at the top' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_text (content) VALUES ('The antidote is small, concrete celebration — not parties, just acknowledgement. Neuroscience research shows that pausing to consciously register a completed step activates the same reward circuits as external praise. In other words, you can learn to give yourself the ‘well done’ your brain keeps waiting for from others.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Celebrate yourself on the way up — not only at the top' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Things worth celebrating that you probably skip');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Celebrate yourself on the way up — not only at the top' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_subtitle (content) VALUES ('How to actually do it (a 30-second practice)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Celebrate yourself on the way up — not only at the top' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'subtitle', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Think of something you completed in the last 7 days that you did not acknowledge at all. Name it now, and say — out loud or silently — ‘that was not nothing.’ How does that feel?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Celebrate yourself on the way up — not only at the top' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_last_messages (content) VALUES ('You don’t need to wait for someone else to notice what you did. You can be the first one to see it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Celebrate yourself on the way up — not only at the top' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief'), 4, 'Thankfulness in hard times (and the trap to avoid)', '‘Both/and’ in practice', NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Thankfulness in hard times (and the trap to avoid)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Here is something important, and you will not always hear it from ‘gratitude’ content online: thankfulness is not a way to skip a difficult feeling. Telling yourself ‘I should just be grateful’ when you are grieving, exhausted or angry does not work — it just adds shame on top of the original pain. That version is called toxic positivity, and it makes people feel worse, not better.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_quote (content, author) VALUES ('‘I should just be grateful’ is not gratitude. It is self-silencing wearing a smile.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_text (content) VALUES ('Real thankfulness in hard times works differently. It does not replace the hard feeling. It sits next to it. You can be genuinely sad about one thing and genuinely grateful for another, in the same hour. This is sometimes called ‘both/and’ thinking in clinical practice, and it is one of the most protective mental habits you can build.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_subtitle (content) VALUES ('‘Both/and’ in practice');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_text (content) VALUES ('Notice the word AND. Not BUT. ‘But’ cancels the first feeling. ‘And’ holds both as true at the same time. This tiny grammar change is doing real psychological work: it stops you having to choose between being honest about your pain and being honest about what is still good.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_mcq (question) VALUES ('You’re going through a hard week. A friend tells you ‘at least you have your health, try to be grateful.’ What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re going through a hard week. A friend tells you ‘at least you have your health, try to be grateful.’ What do you do?' ORDER BY id DESC LIMIT 1), 'Agree, feel guilty for struggling, and push the feelings down.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re going through a hard week. A friend tells you ‘at least you have your health, try to be grateful.’ What do you do?' ORDER BY id DESC LIMIT 1), 'Say ‘I can be grateful for my health AND be exhausted this week. Both are true.’');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’re going through a hard week. A friend tells you ‘at least you have your health, try to be grateful.’ What do you do?' ORDER BY id DESC LIMIT 1), 'Get angry and decide that gratitude is useless.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Write one ‘and’ sentence from your own life right now. Start with something you are finding hard. Add ‘AND’. Finish with something that is still true and good.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'open question', 8, LAST_INSERT_ID());

-- Component 9 for Card 4
INSERT INTO component_last_messages (content) VALUES ('Thankfulness is not a way out of pain. It is how you keep a window open while you walk through it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Thankfulness in hard times (and the trap to avoid)' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief'), 5, 'Saying it out loud: thankfulness toward people', 'Three small ways to practice this week', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Saying it out loud: thankfulness toward people');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Saying it out loud: thankfulness toward people' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Most thankfulness practices are private — a journal, a quiet moment, a noticing. But there is a version that works twice as hard: expressing it directly to the person who matters. Research (including Martin Seligman’s well-known ‘gratitude letter’ studies) shows that expressing thankfulness out loud produces larger and longer-lasting wellbeing effects than private gratitude alone — both for the person saying it and the person receiving it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Saying it out loud: thankfulness toward people' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_quote (content, author) VALUES ('The unspoken thank-you helps no one. The spoken one changes two people at once.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Saying it out loud: thankfulness toward people' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_subtitle (content) VALUES ('Three small ways to practice this week');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Saying it out loud: thankfulness toward people' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_text (content) VALUES ('The key detail is specificity. ‘Thanks for everything’ lands softly. ‘Thank you for calling me on that Tuesday when I was falling apart — I remember exactly what you said’ lands deeply. Specific thankfulness tells the other person that you actually saw them, not just their role in your life.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Saying it out loud: thankfulness toward people' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_mcq (question) VALUES ('There is one person in your life who has quietly helped you and you’ve never properly thanked her. What do you do this week?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'There is one person in your life who has quietly helped you and you’ve never properly thanked her. What do you do this week?' ORDER BY id DESC LIMIT 1), 'Keep meaning to tell her ‘someday’, and never do it.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'There is one person in your life who has quietly helped you and you’ve never properly thanked her. What do you do this week?' ORDER BY id DESC LIMIT 1), 'Send her a 30-second specific thank-you message today — no big production.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'There is one person in your life who has quietly helped you and you’ve never properly thanked her. What do you do this week?' ORDER BY id DESC LIMIT 1), 'Wait until you can do it perfectly, with the right words, at the right moment.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Saying it out loud: thankfulness toward people' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Write her name. Then write the one specific thing she did (or keeps doing) that you want to thank her for. You don’t have to send it today — just write it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Saying it out loud: thankfulness toward people' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 5
INSERT INTO component_last_messages (content) VALUES ('A small, specific, honest thank-you today will mean more to her than a perfect one never sent.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Saying it out loud: thankfulness toward people' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief'), 6, 'Your thankfulness toolkit', 'The menu — pick the one you need today', NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Your thankfulness toolkit');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your thankfulness toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Thankfulness is not one thing. It is a small set of practices you can reach for depending on where your attention is stuck — on what others have, on what you haven’t achieved yet, on what is hard right now, or on what you’ve never said to the people who matter.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your thankfulness toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_subtitle (content) VALUES ('The menu — pick the one you need today');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your thankfulness toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_quote (content, author) VALUES ('A life feels rich not because it has more in it — but because you’ve learned how to see what is already there.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your thankfulness toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_mcq (question) VALUES ('Pick the one you want to practice first this week.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the one you want to practice first this week.' ORDER BY id DESC LIMIT 1), 'Send the specific thank-you I’ve been postponing.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the one you want to practice first this week.' ORDER BY id DESC LIMIT 1), 'Replace one upward-comparison moment with the ‘one year ago’ question.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the one you want to practice first this week.' ORDER BY id DESC LIMIT 1), 'Use the ‘AND’ sentence the next time I’m having a hard day.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your thankfulness toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write one sentence: ‘This week, I will [chosen practice] by [specific small action]’. Keep the promise small enough to keep.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your thankfulness toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_last_messages (content) VALUES ('Thankfulness is not saying everything is fine. It is the quiet, trained ability to see what is good — even while other things are not.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your thankfulness toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Thankfulness: The Quiet Psychological Relief') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
