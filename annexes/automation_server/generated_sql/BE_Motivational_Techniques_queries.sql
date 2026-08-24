-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.512055
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Motivational Techniques for Daily Life
-- ============================================

-- Category: Connection & Community
-- Check/Create category 'Connection & Community'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Connection & Community', 'test description', '2026-08-23 19:54:06.510617');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Connection & Community'), 23, 'Motivational Techniques for Daily Life', 'Learn small, evidence-based motivational techniques you can use at work, at home and with others — even on low-energy days.', 'Women learners (18+)', 15, '2026-08-23 19:54:06.510624');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life'), 1, 'Motivation is not something you find — it is something you trigger', 'Where in your life are you waiting to ‘feel motivated’ before you start?', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Motivation is not something you find — it is something you trigger');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Motivation is not something you find — it is something you trigger' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('We grew up believing motivation arrives first, and action follows. In reality, research on behaviour change shows the opposite: action almost always comes first, and motivation follows once you have started. The women who seem ‘naturally motivated’ are usually the ones who have learned a few small techniques to start before they feel like it. That is what this course gives you — not pep talk, but concrete tools.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Motivation is not something you find — it is something you trigger' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('You don’t need motivation to start. You need to start to get motivation.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Motivation is not something you find — it is something you trigger' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('There is no single motivation technique that works in every context. What helps you finish a report at work is not the same thing that helps you fold laundry at home, or call your mother when you are tired. Over the next cards, you will collect a small menu of techniques for different parts of your life — and learn when to use which.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Motivation is not something you find — it is something you trigger' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_subtitle (content) VALUES ('Where in your life are you waiting to ‘feel motivated’ before you start?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Motivation is not something you find — it is something you trigger' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Name one task you have been putting off for more than a week. Don’t solve it yet — just name it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Motivation is not something you find — it is something you trigger' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Keep that task in mind. By the end of this course, you’ll have three different ways to start it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Motivation is not something you find — it is something you trigger' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life'), 2, 'At work: the 2-minute rule and the bundling trick', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('At work: the 2-minute rule and the bundling trick');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At work: the 2-minute rule and the bundling trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('The 2-minute rule (from behaviour change research, popularised by James Clear) says: shrink the task until the start takes 2 minutes or less. You don’t commit to writing the report — you commit to opening the document and writing one sentence. You don’t commit to answering 30 emails — you commit to answering one. Almost every time, momentum carries you further than the 2 minutes.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At work: the 2-minute rule and the bundling trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_quote (content, author) VALUES ('A task you can start in 2 minutes is a task you can finish.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At work: the 2-minute rule and the bundling trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_text (content) VALUES ('The second technique is temptation bundling: pair a task you don’t feel like doing with something you genuinely enjoy. Boring admin only happens with your favourite playlist. Expense reports only happen with a good coffee. The pleasant thing becomes the trigger for the unpleasant one — and your brain stops resisting the start.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At work: the 2-minute rule and the bundling trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_mcq (question) VALUES ('It’s 9:30 Monday morning. There’s a difficult email you’ve been postponing since Friday. What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'It’s 9:30 Monday morning. There’s a difficult email you’ve been postponing since Friday. What do you do?' ORDER BY id DESC LIMIT 1), 'Wait until you ‘feel ready’ — maybe after lunch, maybe tomorrow.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'It’s 9:30 Monday morning. There’s a difficult email you’ve been postponing since Friday. What do you do?' ORDER BY id DESC LIMIT 1), 'Open the email and write only the first sentence. Stop there if you want.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'It’s 9:30 Monday morning. There’s a difficult email you’ve been postponing since Friday. What do you do?' ORDER BY id DESC LIMIT 1), 'Reorganise your desk first so you can ‘focus properly’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At work: the 2-minute rule and the bundling trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_open_questions (question) VALUES ('Pick one task at work this week. Write down (a) the 2-minute version of starting it, and (b) one pleasant thing you can pair it with.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At work: the 2-minute rule and the bundling trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_last_messages (content) VALUES ('Starting is the hard part. The 2-minute rule makes starting almost too easy to refuse.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At work: the 2-minute rule and the bundling trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life'), 3, 'At home: habit stacking and the night-before trick', 'The night-before trick — examples', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('At home: habit stacking and the night-before trick');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At home: habit stacking and the night-before trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('At home, the enemy of motivation is friction — the small extra steps that drain energy before the task even starts. Two techniques fix this. The first is habit stacking: attach a new behaviour to a habit you already do automatically. The second is the night-before trick: remove tomorrow’s friction tonight, while you still have energy.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At home: habit stacking and the night-before trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Habit stacking — examples');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At home: habit stacking and the night-before trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_subtitle (content) VALUES ('The night-before trick — examples');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At home: habit stacking and the night-before trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Pick one habit you’ve been struggling to start at home. What is one piece of friction you can remove tonight to make tomorrow easier?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At home: habit stacking and the night-before trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'open question', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Tomorrow’s motivation is built tonight, with one small preparation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'At home: habit stacking and the night-before trick' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'last message', 6, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life'), 4, 'Low-energy days: shrink the goal, don’t skip the day', 'Examples of minimum viable days', NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Low-energy days: shrink the goal, don’t skip the day');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Low-energy days: shrink the goal, don’t skip the day' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Some days, you have nothing. Hormonal cycle, bad sleep, emotional weight, illness, grief — they all reduce the energy available for action. On those days, the most motivating thing you can do is not push through. It’s shrink the goal until it fits the energy you actually have.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Low-energy days: shrink the goal, don’t skip the day' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_quote (content, author) VALUES ('On low-energy days, the goal is not progress. The goal is to not break the chain.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Low-energy days: shrink the goal, don’t skip the day' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_text (content) VALUES ('This is called the minimum viable day. If you usually exercise for 30 minutes, the minimum is 5. If you usually write for an hour, the minimum is one paragraph. If you usually cook a real meal, the minimum is toast and an apple. The point is not the size of the action — it is the continuity of the identity. You are still ‘a person who exercises / writes / takes care of herself’. Pushing through and then crashing for three days is far more demotivating than doing 5 minutes today and a normal session tomorrow.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Low-energy days: shrink the goal, don’t skip the day' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_quote (content, author) VALUES ('Be kind to the woman who has to wake up tomorrow as you.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Low-energy days: shrink the goal, don’t skip the day' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'quote', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_subtitle (content) VALUES ('Examples of minimum viable days');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Low-energy days: shrink the goal, don’t skip the day' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'subtitle', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Pick one important habit in your life. Write down what its ‘minimum viable’ version looks like — the version you can do even on your worst day.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Low-energy days: shrink the goal, don’t skip the day' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_last_messages (content) VALUES ('A small action on a hard day protects everything you’ve built. That is real motivation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Low-energy days: shrink the goal, don’t skip the day' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life'), 5, 'With other people: borrow their motivation', 'When you have no one available', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('With other people: borrow their motivation');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'With other people: borrow their motivation' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Motivation is contagious. Decades of social psychology research (Bandura’s social learning theory) show that simply being near someone who is doing a task makes you more likely to do yours. You don’t need their advice — you need their presence. There are three simple ways to use this in daily life.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'With other people: borrow their motivation' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_subtitle (content) VALUES ('Three social motivation techniques');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'With other people: borrow their motivation' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_mcq (question) VALUES ('You’ve been postponing a job application for three weeks. A friend texts ‘what are you up to this Saturday?’ What do you say?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been postponing a job application for three weeks. A friend texts ‘what are you up to this Saturday?’ What do you say?' ORDER BY id DESC LIMIT 1), '‘Nothing much, why?’ — and stay home alone, telling yourself you’ll do the application.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been postponing a job application for three weeks. A friend texts ‘what are you up to this Saturday?’ What do you say?' ORDER BY id DESC LIMIT 1), '‘Let’s sit at a café together — you do your work, I’ll finally do this application.’');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been postponing a job application for three weeks. A friend texts ‘what are you up to this Saturday?’ What do you say?' ORDER BY id DESC LIMIT 1), '‘Can’t, busy with the application’ — then spend the day scrolling.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'With other people: borrow their motivation' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'mcq', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_subtitle (content) VALUES ('When you have no one available');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'With other people: borrow their motivation' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Who is one person you could ask to body-double with you this week, even for one hour?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'With other people: borrow their motivation' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_last_messages (content) VALUES ('You don’t have to motivate yourself alone. Borrowing presence is a real, valid technique.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'With other people: borrow their motivation' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life'), 6, 'Your motivation menu', 'Pick the right tool for the right moment', NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Your motivation menu');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your motivation menu' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Real motivation is not a personality trait — it is a small library of techniques you can pull from, depending on the context. You now have one for each situation. The work is not to use them all. The work is to know which one fits this moment.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your motivation menu' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_subtitle (content) VALUES ('Pick the right tool for the right moment');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your motivation menu' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_quote (content, author) VALUES ('Motivation is not what you have. It’s what you do when you don’t have it.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your motivation menu' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_mcq (question) VALUES ('Look at the task you named in Card 1 — the one you’ve been postponing. Which technique fits it best?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the task you named in Card 1 — the one you’ve been postponing. Which technique fits it best?' ORDER BY id DESC LIMIT 1), 'The 2-minute rule (just shrink the start).');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the task you named in Card 1 — the one you’ve been postponing. Which technique fits it best?' ORDER BY id DESC LIMIT 1), 'Temptation bundling (pair it with something pleasant).');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the task you named in Card 1 — the one you’ve been postponing. Which technique fits it best?' ORDER BY id DESC LIMIT 1), 'Body doubling (do it next to someone).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your motivation menu' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write one sentence: ‘This week, for [your task], I will use [your technique] by doing [the small first step].’');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your motivation menu' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_last_messages (content) VALUES ('You just built your motivation menu. You don’t need to feel motivated tomorrow — you just need to read it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your motivation menu' AND owner_id = (SELECT id FROM module WHERE title = 'Motivational Techniques for Daily Life') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
