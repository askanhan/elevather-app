-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.525250
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Strategies and Tools to Strengthen Self-Confidence
-- ============================================

-- Category: Confidence & Communication
-- Check/Create category 'Confidence & Communication'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Confidence & Communication', 'test description', '2026-08-23 19:54:06.523102');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Confidence & Communication'), 14, 'Strategies and Tools to Strengthen Self-Confidence', 'Learn practical, psychology-based tools women can use daily to build and sustain genuine self-confidence.', 'Women learners (18+)', 15, '2026-08-23 19:54:06.523112');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence'), 1, 'What self-confidence really is (and isn’t)', 'Where in your life do you most often confuse ‘not feeling ready’ with ‘not being capable’?', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('What self-confidence really is (and isn’t)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What self-confidence really is (and isn’t)' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Self-confidence is not the absence of fear, and it is not feeling amazing all the time. In psychology, self-confidence is best understood as the trust you place in your own ability to act, cope and recover – even when you feel unsure. It is built, not born. Research on self-efficacy (Bandura) shows that confidence grows mainly through small, repeated experiences of acting despite doubt. That means confidence is a skill, which means you can train it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What self-confidence really is (and isn’t)' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('You don’t need to feel confident to act. You need to act in order to feel confident.', 'Adapted from self-efficacy research (A. Bandura)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What self-confidence really is (and isn’t)' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_subtitle (content) VALUES ('Where in your life do you most often confuse ‘not feeling ready’ with ‘not being capable’?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What self-confidence really is (and isn’t)' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Think of a time you did something even though you did not feel confident. What made you take that step? Write 2–3 sentences.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What self-confidence really is (and isn’t)' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'open question', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Confidence is a practice, not a personality trait. You are about to practice it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What self-confidence really is (and isn’t)' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'last message', 6, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence'), 2, 'Meet your inner critic', 'What are the 2–3 sentences your inner critic repeats most often?', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Meet your inner critic');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner critic' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Almost every woman has an inner voice that says ‘you’re not good enough’, ‘they’ll notice you’re faking it’, or ‘who do you think you are?’. That voice is not the truth. It is a mental habit – often built up over many years of comparison, criticism, or cultural pressure. In Cognitive Behavioural Therapy (CBT), we call these automatic negative thoughts. The first step to weakening them is simple: notice them, name them, and separate them from you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner critic' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_quote (content, author) VALUES ('You are not your thoughts. You are the one who notices them.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner critic' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_subtitle (content) VALUES ('What are the 2–3 sentences your inner critic repeats most often?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner critic' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_mcq (question) VALUES ('Which of these sounds most like your inner critic?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which of these sounds most like your inner critic?' ORDER BY id DESC LIMIT 1), '‘You’ll embarrass yourself if you try.’');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which of these sounds most like your inner critic?' ORDER BY id DESC LIMIT 1), '‘Others are more qualified than you.’');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which of these sounds most like your inner critic?' ORDER BY id DESC LIMIT 1), '‘You got lucky last time – you won’t this time.’');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner critic' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_open_questions (question) VALUES ('Write down one recurring critical sentence you say to yourself. Then rewrite it as if you were talking to a close friend with the same worry.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner critic' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_last_messages (content) VALUES ('You don’t have to silence the critic. You just have to stop obeying it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner critic' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence'), 3, 'The evidence log: proof your brain will not give you for free', 'What would change if you stopped waiting to feel confident and started collecting evidence instead?', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('The evidence log: proof your brain will not give you for free');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The evidence log: proof your brain will not give you for free' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('The brain has a negativity bias: it remembers failures more easily than successes. That is one reason capable women still feel incapable. The fix is simple but powerful: collect evidence. Each evening, write down three small things you did well that day – a conversation you handled, a decision you made, a moment you showed up. Over time, this rewires attention and becomes a reference list your brain can pull from when confidence drops.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The evidence log: proof your brain will not give you for free' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_quote (content, author) VALUES ('Confidence is the memory of things you’ve done well – if you let yourself remember them.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The evidence log: proof your brain will not give you for free' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('90-second demo: a woman doing the evening 3-wins routine before bed.', '90.0', 'Short demo of a woman writing three wins in a notebook', 'Short, calming 90-second clip: woman sits on her bed with a small notebook, writes three short sentences, smiles slightly, closes the notebook. Warm lighting, no dialogue, soft ambient music. Text overlay: ‘Three wins. Every evening. That’s the practice.’');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The evidence log: proof your brain will not give you for free' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'video', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_subtitle (content) VALUES ('What would change if you stopped waiting to feel confident and started collecting evidence instead?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The evidence log: proof your brain will not give you for free' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Write down three things you did well today. They can be small. Smaller is actually better for this exercise.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The evidence log: proof your brain will not give you for free' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_last_messages (content) VALUES ('You are more capable than your memory lets you believe. The notebook will prove it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The evidence log: proof your brain will not give you for free' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence'), 4, 'Your body speaks first: posture, breath and voice', 'What does your body usually do just before a moment where you lose confidence?', NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Your body speaks first: posture, breath and voice');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your body speaks first: posture, breath and voice' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Confidence is not only in your thoughts – it lives in your body. When you shrink, speak softly, or hold your breath, your nervous system interprets that as danger, and your thoughts follow. When you take up a little more space, slow your breath, and let your voice land, the opposite happens: your body tells your brain ‘I am safe, I am here’. Two minutes of intentional posture and breathing before a difficult moment (a meeting, a call, a conversation) can measurably lower stress and steady your voice.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your body speaks first: posture, breath and voice' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_quote (content, author) VALUES ('Before you change how you think, change how you stand.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your body speaks first: posture, breath and voice' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('60-second guided reset: posture + 4-6 breathing before a stressful moment.', '60.0', 'Guided 60-second body reset before a difficult moment', 'A clinical psychologist (Vision Tree) guides the viewer through a 60-second reset: plant feet, lengthen spine, drop shoulders, inhale 4 seconds / exhale 6 seconds, three rounds. Calm, clear tone. Subtitles in EN/FR/NL/TR. Warm indoor lighting.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your body speaks first: posture, breath and voice' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'video', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_subtitle (content) VALUES ('What does your body usually do just before a moment where you lose confidence?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your body speaks first: posture, breath and voice' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_mcq (question) VALUES ('You are about to walk into a meeting where you feel small. Which 60-second reset do you choose?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are about to walk into a meeting where you feel small. Which 60-second reset do you choose?' ORDER BY id DESC LIMIT 1), 'Plant your feet, drop your shoulders, breathe in 4 / out 6, three times.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are about to walk into a meeting where you feel small. Which 60-second reset do you choose?' ORDER BY id DESC LIMIT 1), 'Grip your notes tighter and rehearse the worst case in your head.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You are about to walk into a meeting where you feel small. Which 60-second reset do you choose?' ORDER BY id DESC LIMIT 1), 'Check your phone to distract yourself until the door opens.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your body speaks first: posture, breath and voice' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Which of these is easiest for you to practice this week: posture, breath, or voice? Write one sentence about where and when you will use it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your body speaks first: posture, breath and voice' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_last_messages (content) VALUES ('Your body can walk into the room confident before your thoughts catch up.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your body speaks first: posture, breath and voice' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence'), 5, 'Act first, feel second', 'What is one small action you have been postponing until you ‘feel ready’?', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Act first, feel second');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Act first, feel second' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('One of the most common traps is waiting to feel ready. Confidence does not arrive and then produce action – it is the other way around. In behavioural activation (used in clinical psychology for low mood and anxiety), the principle is simple: take the small action, and let the feeling update itself afterwards. The women who seem most confident are rarely those who feel the least fear. They are the ones who have practiced acting with fear present.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Act first, feel second' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_quote (content, author) VALUES ('Motion creates emotion. The step comes first.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Act first, feel second' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_subtitle (content) VALUES ('What is one small action you have been postponing until you ‘feel ready’?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Act first, feel second' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_mcq (question) VALUES ('A role you want to apply for has opened. You are only 70% qualified. What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A role you want to apply for has opened. You are only 70% qualified. What do you do?' ORDER BY id DESC LIMIT 1), 'Wait 6 months, tell yourself you need more experience, hope it reopens.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A role you want to apply for has opened. You are only 70% qualified. What do you do?' ORDER BY id DESC LIMIT 1), 'Send the application today, exactly as you are. You can learn the other 30% on the way.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'A role you want to apply for has opened. You are only 70% qualified. What do you do?' ORDER BY id DESC LIMIT 1), 'Ask three people whether you should apply, and do what the majority says.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Act first, feel second' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Write down one small, specific action you will take in the next 48 hours, before you feel ready. Keep it concrete: what, when, and where.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Act first, feel second' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_last_messages (content) VALUES ('Confidence is the side-effect of action, not its prerequisite.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Act first, feel second' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence'), 6, 'Your self-confidence toolkit', 'Which pillar will you practice first this week?', NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Your self-confidence toolkit');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your self-confidence toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Self-confidence is not a personality trait you either have or don’t. It is a daily practice built from four pillars: noticing the inner critic without obeying it, collecting evidence your brain won’t give you for free, using your body to shift your state, and acting before you feel ready. You do not need all four at once. Pick one. Practice it for a week. Your confidence will begin to feel less like a mood and more like a muscle.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your self-confidence toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_quote (content, author) VALUES ('You were never broken. You were under-practiced.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your self-confidence toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_subtitle (content) VALUES ('Which pillar will you practice first this week?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your self-confidence toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_mcq (question) VALUES ('Which pillar do you want to start with?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which pillar do you want to start with?' ORDER BY id DESC LIMIT 1), 'Noticing and naming the inner critic.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which pillar do you want to start with?' ORDER BY id DESC LIMIT 1), 'Keeping an evidence log (3 wins a day).');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which pillar do you want to start with?' ORDER BY id DESC LIMIT 1), 'Body reset before difficult moments, or ‘act before ready’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your self-confidence toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write one sentence that starts with ‘This week, I will…’ – and keep it small enough that you can actually keep the promise.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your self-confidence toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_last_messages (content) VALUES ('You just built your first self-confidence toolkit. One practice this week is enough.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your self-confidence toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Strategies and Tools to Strengthen Self-Confidence') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
