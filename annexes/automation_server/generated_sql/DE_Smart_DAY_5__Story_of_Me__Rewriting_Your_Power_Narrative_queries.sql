-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:10.481396
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Story of me: Rewriting your power narrative
-- ============================================

-- Category: Self-Discovery & Inner Stength
-- Check/Create category 'Self-Discovery & Inner Stength'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Self-Discovery & Inner Stength', 'test description', '2026-08-23 19:54:10.479494');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Self-Discovery & Inner Stength'), 4, 'Story of me: Rewriting your power narrative', 'Understand how your personal story shapes your sense of power – and learn to reframe it with intention.', 'women learners', 15, '2026-08-23 19:54:10.479504');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative'), 1, 'Your Story Has Power', 'Mastering the Art of Your Personal Story', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Your Story Has Power');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('The way you tell your story shapes how you see yourself – and how others see you. Research in narrative psychology (McAdams, 2001) shows that people who actively reflect on and reframe their personal narratives report higher resilience, self-efficacy and sense of agency. This lesson invites you to look at your story – not as something that happened to you, but as something you are actively writing.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('You can''t go back and change the beginning, but you can start where you are and change the ending.  : C.S. Lewis', 'write the author''s name here');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('put directly the exact name of the image file and the image format. e.g : generated_image 8.png', 'short description of what the image is', 'A woman opening a large book that emits soft light, pages transforming into a path forward. flat illustration style, minimal details, clean lines, cool color palette (blue, lilac, white, soft purple), no gradients, no shadows, vector-art look, modern and empowering, no text, white background');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1NH_ENhdmotdok1_-V4ybkLSLiW7IUYUS/view?usp=drive_link', 'must be a number', 'short description of what the image is', 'A woman opening a large book that emits soft light, pages transforming into a path forward. flat illustration style, minimal details, clean lines, cool color palette (blue, lilac, white, soft purple), no gradients, no shadows, vector-art look, modern and empowering, no text, white background');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'video', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_subtitle (content) VALUES ('Mastering the Art of Your Personal Story');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'subtitle', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_mcq (question) VALUES ('the question here');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'the question here' ORDER BY id DESC LIMIT 1), 'answer option 1');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'the question here' ORDER BY id DESC LIMIT 1), 'answer option 2');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'the question here' ORDER BY id DESC LIMIT 1), 'answer option 3');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 1

-- List item 8: list element 1...
INSERT INTO component_list (content) VALUES ('list element 1');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- List item 9: list element 2...
INSERT INTO component_list (content) VALUES ('list element 2');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'list', 9, LAST_INSERT_ID());

-- List item 10: list element 3...
INSERT INTO component_list (content) VALUES ('list element 3');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'list', 10, LAST_INSERT_ID());

-- List item 11: list element 4...
INSERT INTO component_list (content) VALUES ('list element 4');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'list', 11, LAST_INSERT_ID());

-- Component 12 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Begin with curiosity. Your story is not fixed – it is alive.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Story Has Power' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'last message', 12, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative'), 2, 'What is a Power Narrative?', 'Which phrase feels more familiar: "I managed to..." or "I was lucky that..."?', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('What is a Power Narrative?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is a Power Narrative?' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('A power narrative is the story you tell yourself about who you are, what you are capable of, and where you belong. It is built from your experiences, the language you use, and the meanings you assign to events. Some narratives expand you. Others limit you – without you even noticing.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is a Power Narrative?' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_quote (content, author) VALUES ('You are the author of your story. Even when you didn''t choose the plot.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is a Power Narrative?' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Which phrase feels more familiar: "I managed to..." or "I was lucky that..."?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is a Power Narrative?' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative'), 3, 'The Stories That Limit Us', 'Do any of these sound familiar?', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('The Stories That Limit Us');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Stories That Limit Us' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Psychologists call them "limiting narratives" – internalized stories like "I''m not qualified enough", "I speak up too much", or "I don''t belong here." Research shows these narratives are often absorbed from social environments (family, school, media) and reinforced through repetition – not through fact.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Stories That Limit Us' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Do any of these sound familiar?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Stories That Limit Us' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 3

-- List item 4: Common limiting narratives women carry:...
INSERT INTO component_list (content) VALUES ('Common limiting narratives women carry:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Stories That Limit Us' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: I need to be perfect before I speak....
INSERT INTO component_list (content) VALUES ('I need to be perfect before I speak.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Stories That Limit Us' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: My success was luck, not skill...
INSERT INTO component_list (content) VALUES ('My success was luck, not skill');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Stories That Limit Us' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: Being assertive makes me difficult....
INSERT INTO component_list (content) VALUES ('Being assertive makes me difficult.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The Stories That Limit Us' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative'), 4, 'How to Rewrite a Narrative', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('How to Rewrite a Narrative');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to Rewrite a Narrative' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Rewriting a narrative does not mean denying difficult experiences. It means changing the meaning you give them. Cognitive reframing, a tool from cognitive-behavioral psychology, helps you identify unhelpful thought patterns and consciously choose a more empowering interpretation – one that is equally true, but more useful.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to Rewrite a Narrative' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_quote (content, author) VALUES ('We can reframe and recast our lives — not with lies, not with deceptions, but with the truth of who we are and of who we are choosing to become. : Sandra Marinella', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to Rewrite a Narrative' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Think of one experience you tend to describe in a negative way. Write it in one sentence. Now rewrite it: same facts, different frame. What changes?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to Rewrite a Narrative' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative'), 5, 'Finding Your Power Moments', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Finding Your Power Moments');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Finding Your Power Moments' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Before you can rewrite your story, you need raw material: real moments when you showed strength, resilience, courage or care. These moments are often underestimated or forgotten. This exercise helps you surface them.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Finding Your Power Moments' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_mcq (question) VALUES ('Which of these power moments do you tend to overlook?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which of these power moments do you tend to overlook?' ORDER BY id DESC LIMIT 1), 'A time I stood up for something I believed in."');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which of these power moments do you tend to overlook?' ORDER BY id DESC LIMIT 1), 'A time I kept going when it was hard');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Which of these power moments do you tend to overlook?' ORDER BY id DESC LIMIT 1), 'A time I helped someone navigate a challenge.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Finding Your Power Moments' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Choose one of these moments. Describe it in 3–5 sentences. Then write: "This moment shows that I am someone who..."');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Finding Your Power Moments' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative'), 6, 'Write Your Power Statement', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Write Your Power Statement');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Write Your Power Statement' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('A power statement is one or two sentences that reflect who you are at your best – grounded in real experience, not wishful thinking. It is not a slogan. It is a recognition. Research on self-affirmation (Steele, 1988) shows that grounding yourself in your core values and strengths reduces the impact of stress and stereotype threat.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Write Your Power Statement' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_quote (content, author) VALUES ('I am my own experiment. I am my own work of art. Madonna', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Write Your Power Statement' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write your own power statement. Start with: "I am someone who..." – and base it on something real.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Write Your Power Statement' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_last_messages (content) VALUES ('This is your narrative now. You wrote it. Come back to it whenever you forget.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Write Your Power Statement' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative'), 7, 'What You Practiced', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('What You Practiced');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What You Practiced' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Your narrative shapes your power – and you can shape your narrative. / Limiting stories are learned – and can be unlearned. / Power moments are already in your past – waiting to be recognized. / A power statement is a real tool, not a motivational slogan.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What You Practiced' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_last_messages (content) VALUES ('Nice work. Your Journey page has been updated');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What You Practiced' AND owner_id = (SELECT id FROM module WHERE title = 'Story of me: Rewriting your power narrative') LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
