-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.458393
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: nan
-- ============================================

-- Category: this field must be completed ! e.g  :  I Dare, Leadership, ...
-- Check/Create category 'this field must be completed ! e.g  :  I Dare, Leadership, ...'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('this field must be completed ! e.g  :  I Dare, Leadership, ...', 'test description', '2026-08-23 19:54:06.454766');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'this field must be completed ! e.g  :  I Dare, Leadership, ...'), 1, nan, nan, 'working mom, first-time managers, women, ... ', 0, '2026-08-23 19:54:06.454776');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 1, 'Your Inner Potential: Let’s Find It', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Your Inner Potential: Let’s Find It');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Inner Potential: Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('You already have more resources inside you than you probably notice. This lesson is a short journey into your strengths, experiences, values, and beliefs.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Inner Potential: Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_text (content) VALUES ('Scientific research shows that self-awareness is one of the strongest predictors of confidence, emotional intelligence and leadership effectiveness. Studies from organizational psychology and neuroscience confirm that people who regularly reflect on their inner resources manage stress better and lead with more authenticity.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Inner Potential: Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1HKTQ_OasbZtkwa0SDPT3O3q3H7_nFcWw/view?usp=drive_link', 'short description of what the image is', 'detailed explanation of what the image shows');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Inner Potential: Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_last_messages (content) VALUES ('This lesson is a short inner journey. Begin it with curiousity, the starting point of all growth!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your Inner Potential: Let’s Find It' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 2, 'What shapes your inner potential?', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('What shapes your inner potential?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What shapes your inner potential?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Your inner potential is shaped by four forces: strengths, values, experiences, beliefs.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What shapes your inner potential?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://drive.google.com/file/d/1kqUoVG1_38ccaNUBj7Z4LM51vQkmffLF/view?usp=drive_link', NULL, NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What shapes your inner potential?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'video', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_open_questions (question) VALUES ('Think about one important decision or action you took lately. Which of 4 inner forces: strenghts, values, experiences or beliefs, influenced you decisions and actions the strongest and how? Why this one?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What shapes your inner potential?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 3, 'Meet your inner toolkit', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Meet your inner toolkit');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner toolkit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('In order to find out more about your inner potential, you can use some structured methods of reflection. They will help you to systematically reflect on what guides your choices and understand yourself better.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner toolkit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3

-- List item 3: Here are 3 simple tools which you can use to learn...
INSERT INTO component_list (content) VALUES ('Here are 3 simple tools which you can use to learn more about yourself:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner toolkit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 3, LAST_INSERT_ID());

-- List item 4: Journaling – writing to think...
INSERT INTO component_list (content) VALUES ('Journaling – writing to think');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner toolkit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: Experience mapping – seeing patterns in your life...
INSERT INTO component_list (content) VALUES ('Experience mapping – seeing patterns in your life');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner toolkit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: Guided reflection – asking the right questions...
INSERT INTO component_list (content) VALUES ('Guided reflection – asking the right questions');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner toolkit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Swipe to learn more about each of them!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Meet your inner toolkit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 4, 'Journaling - why it works?', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Journaling - why it works?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Journaling - why it works?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Writing helps you slow down your thinking and notice patterns in your experiences. Psychology research shows that short reflective writing can improve self-awareness, learning from experience and emotional clarity. Even a few sentences can reveal insights about your strengths and reactions.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Journaling - why it works?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Take 2 minutes and complete this sentence: 
A recent moment I felt proud of myself was…. and it shows that my strenght comes from.....');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Journaling - why it works?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 4

-- List item 4: Try these prompts to write down your thoughts regu...
INSERT INTO component_list (content) VALUES ('Try these prompts to write down your thoughts regularly and reflect:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Journaling - why it works?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: “Today I felt confident when I…”...
INSERT INTO component_list (content) VALUES ('“Today I felt confident when I…”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Journaling - why it works?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: “One situation I handled well recently was…”...
INSERT INTO component_list (content) VALUES ('“One situation I handled well recently was…”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Journaling - why it works?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: “Something I learned about myself this week is…”...
INSERT INTO component_list (content) VALUES ('“Something I learned about myself this week is…”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Journaling - why it works?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_last_messages (content) VALUES ('Write freely. No perfect answers needed!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Journaling - why it works?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 5, 'Experience mapping - your life leaves clues!', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Experience mapping - your life leaves clues!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Experience mapping is a simple reflection tool used in psychology and personal development. It helps you look at meaningful moments in your life and understand what they reveal about you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_text (content) VALUES ('Instead of asking “What are my strengths?” in theory, you look at real situations and ask: "What did this moment show about me?"');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_text (content) VALUES ('Research on reflective learning shows that when people revisit their experiences, they are better able to recognize their abilities, motivations and personal values.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 5

-- List item 5: Often, your inner potential is already visible in ...
INSERT INTO component_list (content) VALUES ('Often, your inner potential is already visible in moments when you:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: solved a problem...
INSERT INTO component_list (content) VALUES ('solved a problem');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: helped someone...
INSERT INTO component_list (content) VALUES ('helped someone');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: persisted despite difficulty...
INSERT INTO component_list (content) VALUES ('persisted despite difficulty');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- Component 9 for Card 5
INSERT INTO component_last_messages (content) VALUES ('When you look at several moments together, patterns begin to appear.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - your life leaves clues!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 6, 'Experience mapping - discover your patterns', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Experience mapping - discover your patterns');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - discover your patterns' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Think of three moments in your life when you felt proud of yourself or deeply satisfied with what you did.
They can be big achievements or small everyday situations.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - discover your patterns' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_mcq (question) VALUES ('Look at the three moments together. What do they have in common? What did they involve?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the three moments together. What do they have in common? What did they involve?' ORDER BY id DESC LIMIT 1), 'Helping or supporting others');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the three moments together. What do they have in common? What did they involve?' ORDER BY id DESC LIMIT 1), 'Solving problems or finding solutions');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the three moments together. What do they have in common? What did they involve?' ORDER BY id DESC LIMIT 1), 'Organizing or improving something');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the three moments together. What do they have in common? What did they involve?' ORDER BY id DESC LIMIT 1), 'Creating new ideas or things');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the three moments together. What do they have in common? What did they involve?' ORDER BY id DESC LIMIT 1), 'Learning something new');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the three moments together. What do they have in common? What did they involve?' ORDER BY id DESC LIMIT 1), 'Taking initiative');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Look at the three moments together. What do they have in common? What did they involve?' ORDER BY id DESC LIMIT 1), 'Staying calm in difficult situation');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - discover your patterns' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_last_messages (content) VALUES ('Try to see the patterns!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - discover your patterns' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 7, 'Experience mapping - turning paterns into potential', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Experience mapping - turning paterns into potential');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - turning paterns into potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('You’ve just looked at several meaningful experiences and noticed patterns.
Now take one more step: interpret what they reveal about you.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - turning paterns into potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_open_questions (question) VALUES ('Complete the sentence:
“Looking at these experiences, I notice that I often…”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - turning paterns into potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 3, LAST_INSERT_ID());

-- Component 4 for Card 7
INSERT INTO component_open_questions (question) VALUES ('Now try:
“This might mean that one of my strengths or natural talents is…”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - turning paterns into potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- Component 5 for Card 7
INSERT INTO component_last_messages (content) VALUES ('You did great! Small patterns can reveal surprisingly powerful parts of your inner potential.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Experience mapping - turning paterns into potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 8, 'Guided reflection: a mirror for your potential', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('Guided reflection: a mirror for your potential');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Guided reflection: a mirror for your potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('Guided reflection is a simple method used in psychology and coaching to help people understand themselves better.
Instead of asking one big question like “What is my potential?”, the process breaks reflection into smaller guided questions and choices. The prompts help you notice patterns in your reactions and motivations.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Guided reflection: a mirror for your potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_quote (content, author) VALUES ('Research in reflective learning shows that when people reflect with structured prompts, they are more likely to discover their strengths and recognize their inner resources.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Guided reflection: a mirror for your potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 8

-- List item 4: Each answer gives you a small clue about:...
INSERT INTO component_list (content) VALUES ('Each answer gives you a small clue about:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Guided reflection: a mirror for your potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: your strengths,...
INSERT INTO component_list (content) VALUES ('your strengths,');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Guided reflection: a mirror for your potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: your motivations,...
INSERT INTO component_list (content) VALUES ('your motivations,');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Guided reflection: a mirror for your potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: and the situations where your potential naturally ...
INSERT INTO component_list (content) VALUES ('and the situations where your potential naturally appears.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Guided reflection: a mirror for your potential' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 9, 'An excercise on guided reflection', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('An excercise on guided reflection');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('What do you do when something needs to be done?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_mcq (question) VALUES ('Imagine a situation where something isn’t working well in a group or project. What is your natural reaction?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Imagine a situation where something isn’t working well in a group or project. What is your natural reaction?' ORDER BY id DESC LIMIT 1), 'A: I listen to people and try to understand what they need.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Imagine a situation where something isn’t working well in a group or project. What is your natural reaction?' ORDER BY id DESC LIMIT 1), 'B: I start analyzing the problem and possible solutions.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Imagine a situation where something isn’t working well in a group or project. What is your natural reaction?' ORDER BY id DESC LIMIT 1), 'C: I try to organize the situation and create a clear plan.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Imagine a situation where something isn’t working well in a group or project. What is your natural reaction?' ORDER BY id DESC LIMIT 1), 'D: I suggest a new idea or a different way of doing things.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 3, LAST_INSERT_ID());

-- Component 4 for Card 9

-- List item 4: What your answer might reveal...
INSERT INTO component_list (content) VALUES ('What your answer might reveal');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: A - You may have strong social awareness and empat...
INSERT INTO component_list (content) VALUES ('A - You may have strong social awareness and empathy.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: B - Your strength may be problem-solving and logic...
INSERT INTO component_list (content) VALUES ('B - Your strength may be problem-solving and logical thinking.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: C - You may naturally bring structure and coordina...
INSERT INTO component_list (content) VALUES ('C - You may naturally bring structure and coordination.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: D - You may have creative thinking and initiative....
INSERT INTO component_list (content) VALUES ('D - You may have creative thinking and initiative.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- Component 9 for Card 9
INSERT INTO component_last_messages (content) VALUES ('Your spontaneous reactions often reveal how your inner potential shows up in real life!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'An excercise on guided reflection' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 9, LAST_INSERT_ID());

-- ============================================
-- Card 10
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 10, 'Your potential is already active!', NULL, NULL, NULL);

-- Component 1 for Card 10
INSERT INTO component_title (content) VALUES ('Your potential is already active!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your potential is already active!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 10
INSERT INTO component_text (content) VALUES ('Throughout this lesson, you explored moments from your life, your reactions, and the situations that give you energy.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your potential is already active!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 10
INSERT INTO component_quote (content, author) VALUES ('Your potential is rarely something you need to invent. More often, it is something you recognize and develop!', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your potential is already active!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 10
INSERT INTO component_last_messages (content) VALUES ('Your task now is not to become someone else, but to notice and use these strengths more consciously.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your potential is already active!' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 4, LAST_INSERT_ID());

-- ============================================
-- Card 11
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 11, 'Make reflection a habit', NULL, NULL, NULL);

-- Component 1 for Card 11
INSERT INTO component_title (content) VALUES ('Make reflection a habit');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Make reflection a habit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 11
INSERT INTO component_text (content) VALUES ('Inner potential is not something you discover once. It becomes clearer each time you pause and reflect on your experiences.
At the end of the day, ask yourself one small question:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Make reflection a habit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 11
INSERT INTO component_quote (content, author) VALUES ('What did I learn about myself today?', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Make reflection a habit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 11

-- List item 4: Over time, these small reflections help you:...
INSERT INTO component_list (content) VALUES ('Over time, these small reflections help you:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Make reflection a habit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: notice your strengths more clearly...
INSERT INTO component_list (content) VALUES ('notice your strengths more clearly');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Make reflection a habit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: understand what motivates you...
INSERT INTO component_list (content) VALUES ('understand what motivates you');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Make reflection a habit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: make decisions with greater confidence...
INSERT INTO component_list (content) VALUES ('make decisions with greater confidence');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Make reflection a habit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 11
INSERT INTO component_last_messages (content) VALUES ('Congratulations, you have completed the first step of your inner journey!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Make reflection a habit' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
