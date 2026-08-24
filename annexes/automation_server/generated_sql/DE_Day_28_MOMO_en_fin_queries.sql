-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:09.342990
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: nan
-- ============================================

-- Category: this field must be completed ! e.g  :  I Dare, Leadership, ...
-- Check/Create category 'this field must be completed ! e.g  :  I Dare, Leadership, ...'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('this field must be completed ! e.g  :  I Dare, Leadership, ...', 'test description', '2026-08-23 19:54:09.340709');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'this field must be completed ! e.g  :  I Dare, Leadership, ...'), 1, nan, nan, 'working mom, first-time managers, women, ... ', 0, '2026-08-23 19:54:09.340720');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 1, 'Reality and phantasy: a fairy-tale novel', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Reality and phantasy: a fairy-tale novel');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reality and phantasy: a fairy-tale novel' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('The 1973 fantasy novel MOMO centres on a girl who has the power to listen and, through this, to bring people together. In this way, Momo is able to breathe life into time.  But the society around her is changing. There is an ever-increasing emphasis on ‘saving’ time. The GREY GENTLEMEN, who enforce this quietly yet effectively, derive their existence from it. Like rentiers who live off the labour of others. They are never ‘satisfied’ and want to control time themselves. But Momo is connected to herself and to the poetry of nature. Through this connection, she cannot be bought by the Grey Gentlemen, finds her way to Master Hora, and brings time back to the people.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reality and phantasy: a fairy-tale novel' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_text (content) VALUES ('A parable about the POWER OF SOCIAL FORCES over the life of the individual – and the wonderfully simple way in which it is possible to counteract them. The key to this is TIME.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reality and phantasy: a fairy-tale novel' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_quote (content, author) VALUES ('“Because time is life. And life resides in the heart.”', 'Michael Ende');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reality and phantasy: a fairy-tale novel' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('1 Course image Momo_header_sepia_0.jpg', 'Momo and the time', 'Momo and many clocks');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reality and phantasy: a fairy-tale novel' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_mcq (question) VALUES ('Did the author write the fairy-tale novel in Germany?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Did the author write the fairy-tale novel in Germany?' ORDER BY id DESC LIMIT 1), 'Yes, he lived in Bavaria for a long time.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Did the author write the fairy-tale novel in Germany?' ORDER BY id DESC LIMIT 1), 'Yes, he needed a German speaking context to be able writing');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Did the author write the fairy-tale novel in Germany?' ORDER BY id DESC LIMIT 1), 'No, he was accused of escapism because of his uplifting fairy tales, and he lived in Italy.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reality and phantasy: a fairy-tale novel' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Who were the people around Momo? Who were the forces that stole their time? And by what power did Momo manage to bring it back to them? Find out on the following pages. First, read about all the characters involved.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reality and phantasy: a fairy-tale novel' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 2, 'Who are the players?', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Who are the players?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('MOMO');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_text (content) VALUES ('A girl who lives in an abandoned amphitheatre, comes from ‘somewhere’, wears a skirt covered in patches and a jacket that’s far too big for her, has feet as black as her head because she’s always barefoot, and, above all, is a good listener. That’s why people like to come to her – children and adults alike.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_text (content) VALUES ('MOMO’S FRIENDS');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_text (content) VALUES ('The children – they come to see Momo at the amphitheatre every day. When she’s there, they have ‘fantastic’ ideas for games.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_text (content) VALUES ('Beppo, the street sweeper – a sedate, thoughtful older gentleman who exudes wisdom.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_text (content) VALUES ('Gigi, the tour guide – a young, eloquent, fun-loving man,');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_text (content) VALUES ('Nicolà, the bricklayer');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 8, LAST_INSERT_ID());

-- Component 9 for Card 2
INSERT INTO component_text (content) VALUES ('Nino, the innkeeper, and Liliana, his wife Liliana Mr Fusi, the barber');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 9, LAST_INSERT_ID());

-- Component 10 for Card 2
INSERT INTO component_text (content) VALUES ('THE GREY GENTLEMEN');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 10, LAST_INSERT_ID());

-- Component 11 for Card 2
INSERT INTO component_text (content) VALUES ('Among them is BLW/553/c, who wants to get Momo to ‘save time’ with the help of a Bibigirl doll');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 11, LAST_INSERT_ID());

-- Component 12 for Card 2
INSERT INTO component_text (content) VALUES ('CASSIOPEIA, the tortoise');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 12, LAST_INSERT_ID());

-- Component 13 for Card 2
INSERT INTO component_text (content) VALUES ('MASTER HORA, the keeper of time');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 13, LAST_INSERT_ID());

-- Component 14 for Card 2
INSERT INTO component_quote (content, author) VALUES ('“You see, Momo,” [...] “it’s like this: sometimes you have a very long road ahead of you. You think it’s so terribly long; you’ll never manage it, you think. And then you start to hurry. And you hurry more and more. Every time you look up, you see that what lies ahead hasn’t got any shorter. And you try even harder, you start to panic, and in the end you’re completely out of breath and can’t go on. And the road is still lying ahead of you. That’s not the way to do it.” [...]  “You must never think of the whole road at once, do you understand? You must think only of the next step, the next breath, the next stroke of the broom. And again and again, only of the next one.” 

He paused once more and reflected before adding: “Then it becomes a joy; that’s important, then you do your work well. And that’s how it should be.”  And once again, after a long pause, he continued: “Suddenly you realise that, step by step, you’ve covered the whole street. You didn’t even notice how, and you’re not out of breath.” He nodded to himself and concluded: “That’s important.”  

Beppo, the street sweeper', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 14, LAST_INSERT_ID());

-- Component 15 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('2 Momo and players Screenshot 2026-06-28 at 11-33-49 Momo Michael Ende Offizielle Webseite.png', 'Graphic of Momo', 'Graphic of Momo');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 15, LAST_INSERT_ID());

-- Component 16 for Card 2
INSERT INTO component_video (video_url, video_duration_est, video_alt, video_description) VALUES ('https://www.youtube.com/watch?v=ztlUfN6c6d4', '03:25:00', 'Momo’s song', 'Music of the fim by Angelo Branduari');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'video', 16, LAST_INSERT_ID());

-- Component 17 for Card 2
INSERT INTO component_open_questions (question) VALUES ('The last time you took the time to listen to someone, what was the topic?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 17, LAST_INSERT_ID());

-- Component 18 for Card 2
INSERT INTO component_last_messages (content) VALUES ('What is life like for Momo and her friends? Who are the Grey Men? And how are the characters connected? Find out! Swipe to continue…');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Who are the players?' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 18, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 3, 'Momo and her friends', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Momo and her friends');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('The opening chapters describe life as it unfolds in the old amphitheater where Momo has made her home. The children of the neighborhood, none of whom come from wealthy families, love to visit her. In Momo''s company, they let their imaginations run wild and embark on exciting adventures.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_text (content) VALUES ('GIGI’s naturally loose tongue loosens further and he regales the tourists with colorful tales of the story''s wonders, which works particularly well when Momo is there.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_text (content) VALUES ('Because Momo is exceptionally good at one thing: LISTENING. You could almost say she hears people''s hearts. And that has a profound effect on them. Those who are confused and undecided suddenly know what they want. And those who feel insignificant, just one among millions, suddenly realize that they are unique and important to the world.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_text (content) VALUES ('Even the thoughtful BEPPO , the street sweeper, comes to see Momo every day. He tells Momo what''s been on his mind while he''s working. She listens, and Beppo finds the words.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_text (content) VALUES ('Miraculously, neighbours can END A DISPUTE simply when Momo is listening. Two of them went to her and retraced the steps of their conflict. They finally saw that they were both trying to take advantage of each other. After they said this, they laughed and hugged each other.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_quote (content, author) VALUES ('“Go and see Momo!”', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('3 Momo and her friends Amphitheater.jpg', 'Amphitheatre', 'Amphitheatre, the place where Momo lives');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 8, LAST_INSERT_ID());

-- Component 9 for Card 3
INSERT INTO component_mcq (question) VALUES ('What means time?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What means time?' ORDER BY id DESC LIMIT 1), 'A matter of feeling.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What means time?' ORDER BY id DESC LIMIT 1), 'What is measured as time: years, months, weeks, days, hours, seconds.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'What means time?' ORDER BY id DESC LIMIT 1), 'A physical quantity that always depends on space.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 9, LAST_INSERT_ID());

-- Component 10 for Card 3
INSERT INTO component_open_questions (question) VALUES ('What does a fulfilling life mean to you?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'open question', 10, LAST_INSERT_ID());

-- Component 11 for Card 3
INSERT INTO component_last_messages (content) VALUES ('But life isn’t always peaceful, fulfilling and full of inner riches. There are also forces that are cold, heartless and have designs on humanity. Who? And what do they want? Read on…');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Momo and her friends' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 11, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 4, 'Cigars of stolen time: the men in grey', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Cigars of stolen time: the men in grey');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Cigars of stolen time: the men in grey' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Suddenly, there they were: the GREY GENTLEMEN. Ashen-faced, featureless and characterless, dressed in gray from head to toe, and always have a cigar in their mouths. They exude an icy chill. Everyone feels that.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Cigars of stolen time: the men in grey' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_text (content) VALUES ('HAIRDRESSER FUSI also receives a visit from Agent XYQ/384/b of the "Time Savings Bank." The agent coldly calculates for Mr. Fusi how much time he could save: singing, visiting his mother, caring for his parakeet, and much more. All of it can be reduced. Mr. Fusi could get so much more out of his life. The hairdresser now saves time. He treats his customers quickly and surly. He puts his mother in a nursing home. He no longer goes singing and no longer meets with friends. He has forgotten about Agent XYQ/384/b; he has made himself invisible. Like all the other Grey Men. Mr. Fusi believes that saving time is his own decision. It remains unclear whether he "gets his time back," perhaps even with interest? Was that even the agent''s idea?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Cigars of stolen time: the men in grey' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_text (content) VALUES ('More and more people are saving time. Momo hardly has any visitors anymore. So she goes to her friends'' houses. Nino suddenly realizes what he''s missing in his increasingly fast-paced life. The Grey Men now want to distract Momo so that she no longer spends time with her friends.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Cigars of stolen time: the men in grey' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_text (content) VALUES ('AGENT BLW/553/c visits Momo and showers her with dolls. But she says, “I don’t think I can love them.” He is not a “savings bank employee” who manages time (“money”) profitably and “pays it out” in the future. No, the Grey Gentlemen are actually time thieves. Their life energy consists of the time people have saved. Momo is the only one AGENT BLW/553/c doesn''t forget. She is in danger. Then the tortoise Cassiopeia appears. She leads her to Master Hora, the guardian of time, who lives outside of time.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Cigars of stolen time: the men in grey' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_quote (content, author) VALUES ('“If people knew what death really was, they would no longer fear it. And if they no longer feared it, no one could steal their time.”', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Cigars of stolen time: the men in grey' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('4 Grey Men Screenshot 2026-06-28 at 11-35-03 Momo Michael Ende Offizielle Webseite.png', 'The Grey Men', 'A cigarette of stolen time, smoke');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Cigars of stolen time: the men in grey' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 7, LAST_INSERT_ID());

-- Component 8 for Card 4
INSERT INTO component_last_messages (content) VALUES ('The Grey Gentlemen are reaching out to seize humanity’s time. Yet it is one man in particular who sees through them – and comes close to the miracle of time. In the next instalment...');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Cigars of stolen time: the men in grey' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 5, 'Hour Flowers and new life', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Hour Flowers and new life');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Hour Flowers and new life' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Master Hora explains to Momo that the Grey Men are made of precisely the time that people save, time that the GREY MEN HAVE STOLEN from them in this way. They have humanity in their power. NOW THEY WANT TO CONTROL TIME ITSELF. They demand that Momo lead them to Master Hora.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Hour Flowers and new life' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_text (content) VALUES ('A SHOWDOWN ensues between the power of profit maximization, rationalization, and sensual depletion on the one hand, and the "eternal" power of time (nature) and poetry on the other. Master Hora falls asleep. TIME stands still. And with it, the WORLD. Only Momo can move for one hour, because she received an HOUR-FLOWER from Master Hora.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Hour Flowers and new life' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_text (content) VALUES ('The Grey Men can no longer steal time at this hour and must access their time reserves, the frozen HOUR-FLOWERS from which their cigars are made. These are stored in a large storehouse. Momo seals it off with her hour-flower. This also cuts off the Grey Men''s access to their time reserves. They DISSOLVE into nothingness and eventually all disappear. Momo reopens the room. The frozen hour-flowers—the people''s saved time—thaw. They form into "clouds," a "storm of pure liberated time." Thus, time is returned to the world. People once again TAKE TIME for one another. Momo meets her friends, and they celebrate a great feast.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Hour Flowers and new life' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('5 Master Hora Screenshot 2026-06-28 at 11-35-51 Momo Michael Ende Offizielle Webseite.png', 'Dining table – Master Hora', 'A dining table, with a coffee pot, plates and a knive, a bread basket and other items – time to get together');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Hour Flowers and new life' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_mcq (question) VALUES ('Is the book or film *Momo* a critique of capitalism?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Is the book or film *Momo* a critique of capitalism?' ORDER BY id DESC LIMIT 1), 'No, the focus is on the ability to communicate effectively.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Is the book or film *Momo* a critique of capitalism?' ORDER BY id DESC LIMIT 1), 'No, the plot isn''t about money.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Is the book or film *Momo* a critique of capitalism?' ORDER BY id DESC LIMIT 1), 'Yes, the time saved and the time stolen are symbols of the pressure to grow, the pursuit of profit and a ‘dead life’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Hour Flowers and new life' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_last_messages (content) VALUES ('What interpretations of *Momo* are possible? There are two in particular…');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Hour Flowers and new life' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = nan), 6, 'Interpretations', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Interpretations');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Interpretations' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Momo has been translated into many languages and read by twelve million people worldwide. Everyone has their own perspective. Here are two points of view:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Interpretations' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_text (content) VALUES ('1/ CULTURAL CRITIQUE: Momo, the children, and their friends symbolize the vibrant contrast to the ''fast,'' alienated, and meaningless lives that modern industrial mass societies produce. Constantly sacrificing oneself for a ''higher purpose'' and that only in quantitative dimensions appears as a loss of life—and of community. Time is seen as the qualitative counterforce to this. The ordinary lives of Momo and the "little people" are embedded in the cycle of birth and death. Listening and taking time unleash imagination, creativity, phantasy and abundance. Momo is able to defeat the Grey Men because she has seen into the hearts of her friends and, through Master Hora, has experienced the wonder and POETRY OF TIME. This profound, benevolent connection to life even unsettles a time agent.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Interpretations' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_text (content) VALUES ('2/ ECONOMIC CRITIQUE: The economist Werner Onken identifies the Grey Men as financial agents who impose their profit-driven logic on societies. The power of money encounters the girl Momo, who "transforms money into a servant of humankind." For him, the fairy-tale novel conveys the confidence that the present "can be cured by changing the monetary system..." In a letter to Werner Onken, the author Michael Ende wrote that the idea of ''aging money'' forms the background of his book, "...since I have come to the conclusion that the cultural question cannot be solved without simultaneously, or even beforehand, solving the monetary question."');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Interpretations' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_quote (content, author) VALUES ('“The whole world is one big story, and we’re part of it.”', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Interpretations' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'quote', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('6 Interpretations Illustrationen.jpg', 'Time in phantasia', 'Buildings and alleyways');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Interpretations' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'image', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_last_messages (content) VALUES ('Arrived! Congratulations. You made a journey through time, life and society. It may encourage you to slow down and ask what really touches you and gives you energy, hope and meaning.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Interpretations' AND owner_id = (SELECT id FROM module WHERE title = nan) LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
