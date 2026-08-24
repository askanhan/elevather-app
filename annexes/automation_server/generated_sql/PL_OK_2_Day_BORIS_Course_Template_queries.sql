-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.403799
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: nan
-- ============================================

-- Category: this field must be completed ! e.g  :  I Dare, Leadership, ...
-- Check/Create category 'this field must be completed ! e.g  :  I Dare, Leadership, ...'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('this field must be completed ! e.g  :  I Dare, Leadership, ...', 'test description', '2026-08-23 19:54:06.401359');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'this field must be completed ! e.g  :  I Dare, Leadership, ...'), 1, nan, nan, 'working mom, first-time managers, women, ... ', 0, '2026-08-23 19:54:06.401369');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 1, 'The science behind the Big Five', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('The science behind the Big Five');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The science behind the Big Five' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('The Big Five personality model, also known as  OCEAN (an acronim), comes from decades of psychological research and describes personality across five core dimensions.It was not created by one person or one theory. Instead, it emerged from large-scale empirical studies.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The science behind the Big Five' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_text (content) VALUES ('In the mid-20th century, researchers analyzed thousands of words people use to describe personality. Using a method called factor analysis, they identified patterns that consistently appeared across different cultures and languages. Some of the most influential researchers in this field were Lewis Goldberg, Paul Costa and Robert McCrea.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The science behind the Big Five' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1qXaY8f679EDqdv5K3-pwWQy1mSwM4Xjv/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The science behind the Big Five' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1cDxHaAJmmMmzFeA_qPEn3-e3smNJx1LH/view?usp=drive_link', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The science behind the Big Five' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'video', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Get to know the tool and see where you are on the Big Five scale!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'The science behind the Big Five' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 6, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 2, '5 dimentions of personality', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('5 dimentions of personality');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '5 dimentions of personality' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2

-- List item 2: The Big Five describes personality through five di...
INSERT INTO component_list (content) VALUES ('The Big Five describes personality through five dimensions:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '5 dimentions of personality' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 2, LAST_INSERT_ID());

-- List item 3: Openness - creativity, curiosity, openness to new ...
INSERT INTO component_list (content) VALUES ('Openness - creativity, curiosity, openness to new experiences');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '5 dimentions of personality' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 3, LAST_INSERT_ID());

-- List item 4: Conscientiousness - involves being organized, resp...
INSERT INTO component_list (content) VALUES ('Conscientiousness - involves being organized, responsible, goal - oriented');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '5 dimentions of personality' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: Extraversion - sociability, assertiveness, high en...
INSERT INTO component_list (content) VALUES ('Extraversion - sociability, assertiveness, high energy');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '5 dimentions of personality' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: Agreeableness reflects empathy, cooperation, a con...
INSERT INTO component_list (content) VALUES ('Agreeableness reflects empathy, cooperation, a concern for others');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '5 dimentions of personality' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_text (content) VALUES ('These five traits are considered dimensions, not categories, meaning everyone has some degree of each trait. For example, a leader might be moderately extraverted, highly conscientious, and low in neuroticism, creating a unique personality profile that influences her leadership style.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '5 dimentions of personality' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_text (content) VALUES ('Understanding your unique Big Five profile can help you pinpoint your leadership strengths and areas for growth. For women aspiring to lead with confidence and authenticity, this tool offers a personalized roadmap for development - helping you by embracing who you are and growing strategically from there.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = '5 dimentions of personality' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 8, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 3, 'How to use this test?', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('How to use this test?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to use this test?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('On the following screens you will find a simplified version of the Big Five personality test. It won''t give you a full psycological profile, but an insight in into your personality traits. Answer honestly - what you really think you would do, not what you think you should do.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to use this test?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Let''s begin!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'How to use this test?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 3, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 4, 'Openess', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Openess');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Openess' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_mcq (question) VALUES ('How do you usually relate to change and unfamiliar situations? Choose what fits you best:');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually relate to change and unfamiliar situations? Choose what fits you best:' ORDER BY id DESC LIMIT 1), 'A: I actively seek new ideas, enjoy exploring different perspectives,and feel energized by novelty');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually relate to change and unfamiliar situations? Choose what fits you best:' ORDER BY id DESC LIMIT 1), 'B: I am open to new things, but I also appreciate what is familiar and proven.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually relate to change and unfamiliar situations? Choose what fits you best:' ORDER BY id DESC LIMIT 1), 'C: I prefer clarity, structure and practical approaches rather than experimenting too much.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Openess' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 4

-- List item 3: What you answer suggests:...
INSERT INTO component_list (content) VALUES ('What you answer suggests:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Openess' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 3, LAST_INSERT_ID());

-- List item 4: A - You may have strong curiosity, imagination and...
INSERT INTO component_list (content) VALUES ('A - You may have strong curiosity, imagination and creative thinking. You are likely comfortable with change and new perspectives.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Openess' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: B - You may balance curiosity with practicality, a...
INSERT INTO component_list (content) VALUES ('B - You may balance curiosity with practicality, adapting when needed but staying grounded.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Openess' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: C - You may value stability, clarity and efficienc...
INSERT INTO component_list (content) VALUES ('C - You may value stability, clarity and efficiency, focusing on what works rather than what is new.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Openess' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 5, 'Organisation and self management', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Organisation and self management');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Organisation and self management' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_mcq (question) VALUES ('How do you approach responsibilities, goals and tasks? Choose 1 answer:');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you approach responsibilities, goals and tasks? Choose 1 answer:' ORDER BY id DESC LIMIT 1), 'A: I like planning, staying organized and following through on what I start');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you approach responsibilities, goals and tasks? Choose 1 answer:' ORDER BY id DESC LIMIT 1), 'B: I can be organized when needed but I also adapt and stay flexible');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you approach responsibilities, goals and tasks? Choose 1 answer:' ORDER BY id DESC LIMIT 1), 'C: I prefer spontaneity and don’t like strict structure or detailed planning');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Organisation and self management' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 5

-- List item 3: What your answer suggests:...
INSERT INTO component_list (content) VALUES ('What your answer suggests:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Organisation and self management' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 3, LAST_INSERT_ID());

-- List item 4: A - You may have strong reliability and goal focus...
INSERT INTO component_list (content) VALUES ('A - You may have strong reliability and goal focus.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Organisation and self management' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: B - You may combine structure with flexibility, ad...
INSERT INTO component_list (content) VALUES ('B - You may combine structure with flexibility, adjusting depending on the situation.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Organisation and self management' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: C - You may value adaptability, working best witho...
INSERT INTO component_list (content) VALUES ('C - You may value adaptability, working best without rigid constraints.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Organisation and self management' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 6, 'Extraversion', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Extraversion');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Extraversion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_mcq (question) VALUES ('Where do you usually get your energy from?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Where do you usually get your energy from?' ORDER BY id DESC LIMIT 1), 'A: Being around people, interacting and engaging in dynamic environments.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Where do you usually get your energy from?' ORDER BY id DESC LIMIT 1), 'B: A balance of social interaction and time alone.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Where do you usually get your energy from?' ORDER BY id DESC LIMIT 1), 'C: I get energy from quiet time and reflection, being on my own.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Extraversion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_open_questions (question) VALUES ('What your answer suggests');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Extraversion' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 7, 'Agreableness', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Agreableness');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Agreableness' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_mcq (question) VALUES ('How do you usually approach relationships and collaboration? Choose 1 answer.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually approach relationships and collaboration? Choose 1 answer.' ORDER BY id DESC LIMIT 1), 'A: I naturally focus on harmony, empathy, and supporting others');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually approach relationships and collaboration? Choose 1 answer.' ORDER BY id DESC LIMIT 1), 'B: I balance being cooperative with expressing my own needs');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually approach relationships and collaboration? Choose 1 answer.' ORDER BY id DESC LIMIT 1), 'C: I tend to be direct, focused on outcomes rather than maintaining harmony');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Agreableness' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 7

-- List item 3: What your answer suggests:...
INSERT INTO component_list (content) VALUES ('What your answer suggests:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Agreableness' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 3, LAST_INSERT_ID());

-- List item 4: A -You may have strong empathy, high lever trust a...
INSERT INTO component_list (content) VALUES ('A -You may have strong empathy, high lever trust and feel better when cooperating.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Agreableness' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: B - You may know how to combine care for others wi...
INSERT INTO component_list (content) VALUES ('B - You may know how to combine care for others with assertiveness.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Agreableness' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: C - You may value honesty, clarity and efficiency ...
INSERT INTO component_list (content) VALUES ('C - You may value honesty, clarity and efficiency in interactions and are not scared of entering a conflict.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Agreableness' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 8, 'Emotional stability', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('Emotional stability');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Emotional stability' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_mcq (question) VALUES ('How do you usually react in challenging or stressful situations?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually react in challenging or stressful situations?' ORDER BY id DESC LIMIT 1), 'A: I stay relatively calm and emotionally steady in the majority of stressful situations.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually react in challenging or stressful situations?' ORDER BY id DESC LIMIT 1), 'B: It depends on the situation, I sometimes get overwhelmend by emotions.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'How do you usually react in challenging or stressful situations?' ORDER BY id DESC LIMIT 1), 'C: I often feel stress or worry or experience other strong emotional reactions.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Emotional stability' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_open_questions (question) VALUES ('What your answer sugggests:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Emotional stability' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 8

-- List item 4: That was the last dimention of The Big Five Model....
INSERT INTO component_list (content) VALUES ('That was the last dimention of The Big Five Model. Your answers give you insight on where you are on a scale of each dimention.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Emotional stability' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 9, 'Your unique combination', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('Your unique combination');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your unique combination' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('The Big Five model does not classify people into fixed “types.” Instead, it shows to what degree, from low to high, you express different patterns of thinking, behavior and motivation. This means you can be high in one dimention, moderate in another and lower in a third and this uniqie combination makes you yourself.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your unique combination' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_text (content) VALUES ('Want to do deeper? You can find free, full Big Five tests online that provide more detailed results. We encourage you to explore them as
they can give you a deeper insight into your personality and potential.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your unique combination' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Remember: your personality is not something to change! It’s something to understand and use consciously. Thank you for completing this Day!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your unique combination' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
