-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:05.356402
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: nan
-- ============================================

-- Category: this field must be completed ! e.g  :  I Dare, Leadership, ...
-- Check/Create category 'this field must be completed ! e.g  :  I Dare, Leadership, ...'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('this field must be completed ! e.g  :  I Dare, Leadership, ...', 'test description', '2026-08-23 19:54:05.353692');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'this field must be completed ! e.g  :  I Dare, Leadership, ...'), 1, nan, nan, 'working mom, first-time managers, women, ... ', 0, '2026-08-23 19:54:05.353702');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 1, 'What is advocacy and why is it important?', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('What is advocacy and why is it important?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Advocacy refers to deliberate and organised efforts aimed at influencing decision-makers (the government, local authorities, institutions) in order to change the law, policies or social practices. It involves representing the interests of specific groups, such as women, and building public support for important causes. To build public support for important issues, you need to be able to clearly state what you want to do, why your action is important, and what you expect from others. You must be able to clearly formulate your advocacy appeal');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1XZinKOEnQ2QKYMlCV1imTm54hg8aLNKA/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 1

-- List item 4: Advocacy is important because:...
INSERT INTO component_list (content) VALUES ('Advocacy is important because:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: it amplifies the voices of marginalised individual...
INSERT INTO component_list (content) VALUES ('it amplifies the voices of marginalised individuals and groups');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: it influences decisions and systemic change...
INSERT INTO component_list (content) VALUES ('it influences decisions and systemic change');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: it increases institutional accountability and tran...
INSERT INTO component_list (content) VALUES ('it increases institutional accountability and transparency');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- List item 8: it raises awareness and changes social attitudes...
INSERT INTO component_list (content) VALUES ('it raises awareness and changes social attitudes');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 8, LAST_INSERT_ID());

-- Component 9 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Have you ever had to advocate for a cause or persuade someone to take action because you couldn’t manage it on your own? 
If so, try to recall what made you successful.
If not, choose one issue that’s important to you and think about what might convince people to get involved in finding a solution to this problem.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'What is advocacy and why is it important?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 9, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 2, 'Advocacy Appeal - How speak clearly and specifically?', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Advocacy Appeal - How speak clearly and specifically?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy Appeal - How speak clearly and specifically?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('An advocacy appeal should be specific and concise, so that it gets attention and is remembered');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy Appeal - How speak clearly and specifically?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1lBfBNvE03Kz1rMv59qHTDGLjVczahttC/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy Appeal - How speak clearly and specifically?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 2

-- List item 4: 4 Key elements of advocacy messaging:...
INSERT INTO component_list (content) VALUES ('4 Key elements of advocacy messaging:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy Appeal - How speak clearly and specifically?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: 1. The social benefits of resolving the issue...
INSERT INTO component_list (content) VALUES ('1. The social benefits of resolving the issue');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy Appeal - How speak clearly and specifically?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: 2. Issue that needs to be addressed by decision-ma...
INSERT INTO component_list (content) VALUES ('2. Issue that needs to be addressed by decision-makers');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy Appeal - How speak clearly and specifically?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: 3. Solution which you propose and want to implemen...
INSERT INTO component_list (content) VALUES ('3. Solution which you propose and want to implement');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy Appeal - How speak clearly and specifically?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_last_messages (content) VALUES ('We’ll show you how to prepare an effective appeal !');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy Appeal - How speak clearly and specifically?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 3, 'Advocacy appeal - benefits', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Advocacy appeal - benefits');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal - benefits' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('The most important thing is to inspire people to envision change. It is not the problems themselves, but the belief that we can make things better and improve someone’s life that motivates us to take action.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal - benefits' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1_1xqaBSm6FgNlMBIZi46JZsIZFSpptxt/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal - benefits' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_open_questions (question) VALUES ('What is your vision for change to promote gender equality?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal - benefits' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 4, 'Advocacy appeal_problems and needs', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Advocacy appeal_problems and needs');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal_problems and needs' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Change generally stems from the fact that we are dissatisfied with a particular situation. We see a problem. When we consider the social, professional and family circumstances of women, we can observe many challenges, such as: Unequal pay for the same work with the same qualifications, not being promoted to higher positions despite having the necessary qualifications, their voices being disregarded in politics, bearing full responsibility for caring for ageing parents, etc. To be successful in advocacy, it is worth focusing on bringing about change in one specific area.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal_problems and needs' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1UVQzuhfCzUM2BqmCNtGGwTGkdqT-JdMH/view?usp=drive_link', 'short description of what the image is', 'detailed explanation of what the image shows');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal_problems and needs' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_mcq (question) VALUES ('In which area of life would you like to advocate for the improvement of women’s situations?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'In which area of life would you like to advocate for the improvement of women’s situations?' ORDER BY id DESC LIMIT 1), 'private and family life');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'In which area of life would you like to advocate for the improvement of women’s situations?' ORDER BY id DESC LIMIT 1), 'the social sphere');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'In which area of life would you like to advocate for the improvement of women’s situations?' ORDER BY id DESC LIMIT 1), 'the political arena');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'In which area of life would you like to advocate for the improvement of women’s situations?' ORDER BY id DESC LIMIT 1), 'work enviromenal');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'In which area of life would you like to advocate for the improvement of women’s situations?' ORDER BY id DESC LIMIT 1), 'others area');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal_problems and needs' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_open_questions (question) VALUES ('What specific issue would you like to address?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal_problems and needs' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 5, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 5, 'Advocacy appeal-Solitions', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Advocacy appeal-Solitions');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-Solitions' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('These are specific measures that need to be put in place. They may include legal solutions, specific actions, such as training. It is important that you know what needs to be done to bring about change');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-Solitions' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1SoqjCd2A6AgH2oxljBDlR1GhBu6uk1MK/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-Solitions' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_mcq (question) VALUES ('To solve the problem you want to tackle, you need to:');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'To solve the problem you want to tackle, you need to:' ORDER BY id DESC LIMIT 1), 'introduce legislation at national level');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'To solve the problem you want to tackle, you need to:' ORDER BY id DESC LIMIT 1), 'introduce legislation at regional/local level');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'To solve the problem you want to tackle, you need to:' ORDER BY id DESC LIMIT 1), 'organize a social campaign');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'To solve the problem you want to tackle, you need to:' ORDER BY id DESC LIMIT 1), 'to conduct training');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'To solve the problem you want to tackle, you need to:' ORDER BY id DESC LIMIT 1), 'others');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-Solitions' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_open_questions (question) VALUES ('How probable do you think it is that these measures will be implemented? Please rate on a scale of 1 to 5, where 1 means completely unlikely and 5 means very likely.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-Solitions' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 5, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 6, 'Advocacy appeal-main message', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Advocacy appeal-main message');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-main message' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('The main message is what kind of support or action you are seeking, such as backing for your proposal at a meeting. This message may vary depending on the group you are addressing. For example, You might want local residents to sign a petition, or for the local council to allocate funds in the budget for the construction of a nursery in your neighbourhood.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-main message' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1Qb6hCBeB9eAeCxyCMZKke0EMZjgapho2/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-main message' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Do you know what others can do to support your efforts?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Advocacy appeal-main message' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 4, LAST_INSERT_ID());

-- ============================================
-- Card 7
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 7, 'Characteristics of effective advocacy appeal', NULL, NULL, NULL);

-- Component 1 for Card 7
INSERT INTO component_title (content) VALUES ('Characteristics of effective advocacy appeal');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Characteristics of effective advocacy appeal' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 7
INSERT INTO component_text (content) VALUES ('Your message must be: brief – both you and your audience need to be able to remember it – and simple – after hearing it just once, it should be clear what you want to achieve and how.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Characteristics of effective advocacy appeal' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 7
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1zTgW8scH9OE7snG9kUqoGFUVNSyUYcei/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Characteristics of effective advocacy appeal' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 7

-- List item 4: The main features of a good message:...
INSERT INTO component_list (content) VALUES ('The main features of a good message:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Characteristics of effective advocacy appeal' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: avoid commas and flowery language...
INSERT INTO component_list (content) VALUES ('avoid commas and flowery language');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Characteristics of effective advocacy appeal' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: Use everyday language – instead of ‘funds’, say ‘m...
INSERT INTO component_list (content) VALUES ('Use everyday language – instead of ‘funds’, say ‘money’; instead of ‘educational institutions’, say ‘schools and nurseries’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Characteristics of effective advocacy appeal' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- List item 7: Use descriptive language, e.g. – “at a meeting of ...
INSERT INTO component_list (content) VALUES ('Use descriptive language, e.g. – “at a meeting of 10 directors, only one person is a woman” instead of: “women are an under-represented group among senior management”.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Characteristics of effective advocacy appeal' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 7, LAST_INSERT_ID());

-- Component 8 for Card 7
INSERT INTO component_open_questions (question) VALUES ('Prepare your message using these four elements. Write it down on a piece of paper, on your phone or on your computer; you’ll be able to check it in the next steps');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Characteristics of effective advocacy appeal' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 8, LAST_INSERT_ID());

-- ============================================
-- Card 8
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 8, 'Speak from the heart and with your head', NULL, NULL, NULL);

-- Component 1 for Card 8
INSERT INTO component_title (content) VALUES ('Speak from the heart and with your head');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Speak from the heart and with your head' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 8
INSERT INTO component_text (content) VALUES ('To persuade people of something, you should write with both your heart and your head; in other words, when writing an advocacy piece, appeal to both the reader’s emotions and their rationality.
To trigger emotions: give the story a protagonist – a specific person or people affected by the current situation – and highlight what might change in their lives or work if your solution were implemented. Appeal to their emotions. Don’t just talk about facts, but about how that person experiences the situation.
To trigger rational thinking: Replace generalities with specifics – swap terms such as ‘numerous’ and ‘many’ for specific figures. Compare the data with other places of a similar nature. Show data on the benefits of implementing the solution. Focus on 2–3 key figures; present the data in a way that makes it easy to remember, e.g. instead of 37.87%, say 38% or just 40%.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Speak from the heart and with your head' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 8
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('https://drive.google.com/file/d/1PNr-YsieiUPhrDSESX6BUXikl3YSop5s/view?usp=drive_link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Speak from the heart and with your head' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 8

-- List item 4: Check your appeal to see if:...
INSERT INTO component_list (content) VALUES ('Check your appeal to see if:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Speak from the heart and with your head' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 4, LAST_INSERT_ID());

-- List item 5: it features a specific female character, e.g. Ms K...
INSERT INTO component_list (content) VALUES ('it features a specific female character, e.g. Ms Krystyna');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Speak from the heart and with your head' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 5, LAST_INSERT_ID());

-- List item 6: contains statistical data and facts...
INSERT INTO component_list (content) VALUES ('contains statistical data and facts');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Speak from the heart and with your head' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'list', 6, LAST_INSERT_ID());

-- ============================================
-- Card 9
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 9, 'Summary', NULL, NULL, NULL);

-- Component 1 for Card 9
INSERT INTO component_title (content) VALUES ('Summary');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 9
INSERT INTO component_text (content) VALUES ('We’ve explained the four key elements an advocacy appeal should include, how it should be structured, and what language to use to make it persuasive. Now it’s time for you to draft your own appeal');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 9
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('link', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 3, LAST_INSERT_ID());

-- Component 4 for Card 9
INSERT INTO component_mcq (question) VALUES ('Check your speech.  Does your appeal have:');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Check your speech.  Does your appeal have:' ORDER BY id DESC LIMIT 1), 'the benefits of the change');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Check your speech.  Does your appeal have:' ORDER BY id DESC LIMIT 1), 'problem description');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Check your speech.  Does your appeal have:' ORDER BY id DESC LIMIT 1), 'a proposal for a specific action that could resolve the problem');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Check your speech.  Does your appeal have:' ORDER BY id DESC LIMIT 1), 'information on what a person should do after reading or listening to this appeal');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Check your speech.  Does your appeal have:' ORDER BY id DESC LIMIT 1), 'an anonymised example of a specific person affected by the problem');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Check your speech.  Does your appeal have:' ORDER BY id DESC LIMIT 1), 'statistical figures');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Check your speech.  Does your appeal have:' ORDER BY id DESC LIMIT 1), 'the informal language');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Check your speech.  Does your appeal have:' ORDER BY id DESC LIMIT 1), 'they are short; they can be delivered in 3 minutes');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 4, LAST_INSERT_ID());

-- Component 5 for Card 9
INSERT INTO component_last_messages (content) VALUES ('To persuade others, it’s not just what you say that matters, but how you say it. Draw on your motivation and enthusiasm when delivering your short speech. What moved and convinced you will surely convince others too!');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Summary' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 5, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
