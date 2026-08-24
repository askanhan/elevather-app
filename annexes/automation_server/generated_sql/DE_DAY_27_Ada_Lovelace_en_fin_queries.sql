-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:07.347210
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Pioneer of Computer Science - ADA LOVELACE 
-- ============================================

-- Category: 6 Inspiration & Role Models
-- Check/Create category '6 Inspiration & Role Models'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('6 Inspiration & Role Models', 'test description', '2026-08-23 19:54:07.345066');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = '6 Inspiration & Role Models'), 27, 'Pioneer of Computer Science - ADA LOVELACE ', 'Learn from the example of Ada Lovelace, a pioneer of programming in 19th century, what it means to develop one’s talents under difficult circumstances – and how important a solid education is in doing so.   ', 'adult learners, women, men, divers ', 0, '2026-08-23 19:54:07.345078');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE '), 1, 'Discover her biography', NULL, NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Discover her biography');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Born on December 10, 1815 in London as Augusta Ada Byron; mother: Anne Isabella Noel-Byron (amateur mathematician), father: Lord Byron (famous English poet)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_text (content) VALUES ('She was frequently ill during her childhood.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('1827: From an early age, she was fascinated by machines and technical inventions. At the age of 12, she wanted to build a flying machine and invented a new discipline of knowledge: ‘Flightology’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_text (content) VALUES ('Early youth: Beginning of friendship with the mathematician Mary Somerville (1780-1872).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_text (content) VALUES ('1833: Beginning of a friendship and long-term working relationship with the mathematician Charles Babbage (1792-1871). He fostered Ada''s talents.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_text (content) VALUES ('Acquaintance with the scientists Andrew Crosse, Sir David Brewster, Charles Wheatstone, Michael Faraday and the writer Charles Dickens.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 7, LAST_INSERT_ID());

-- Component 8 for Card 1
INSERT INTO component_text (content) VALUES ('1835: Marriage to Baron William King (later Count of Lovelace).');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 8, LAST_INSERT_ID());

-- Component 9 for Card 1
INSERT INTO component_text (content) VALUES ('1836, 1837, 1839: Birth of one daughter and two sons.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 9, LAST_INSERT_ID());

-- Component 10 for Card 1
INSERT INTO component_text (content) VALUES ('1840s: various affairs with men, passionate participant in horse betting.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 10, LAST_INSERT_ID());

-- Component 11 for Card 1
INSERT INTO component_text (content) VALUES ('1844: Review of the treatise “Research on Magnetism” by Baron Karl von Reichenbach, unpublished and possibly unfinished.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 11, LAST_INSERT_ID());

-- Component 12 for Card 1
INSERT INTO component_text (content) VALUES ('1848: Ada translated a French article about Charles Babbage''s "Analytical Engine." She also wrote commentaries on it, comprising eight points and as long as the article itself.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 12, LAST_INSERT_ID());

-- Component 13 for Card 1
INSERT INTO component_text (content) VALUES ('27.11.1852 Ada Lovelace dies of cervical cancer.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 13, LAST_INSERT_ID());

-- Component 14 for Card 1
INSERT INTO component_text (content) VALUES ('In 1975, the Pentagon commissioned the development of a universally applicable computer language. It was named ADA after Ada Lovelace.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 14, LAST_INSERT_ID());

-- Component 15 for Card 1
INSERT INTO component_quote (content, author) VALUES ('Forget this world and all its troubles and if possible its multitudinous Charlatans—every thing in short but the Enchantress of Number.', 'Charles Bubbage on Ada Lovelace');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'quote', 15, LAST_INSERT_ID());

-- Component 16 for Card 1
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('Ada_Lovelace card 1.jpg', 'Portrait of Ada Lovelace', 'Ada Lovelace 1836');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'image', 16, LAST_INSERT_ID());

-- Component 17 for Card 1
INSERT INTO component_mcq (question) VALUES ('Was Ada Lovelace the first programmer?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Was Ada Lovelace the first programmer?' ORDER BY id DESC LIMIT 1), 'Yes, she developed a programme for the ‘Analytical Engine’ using the calculation of ‘Bernoulli numbers’ as an example');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Was Ada Lovelace the first programmer?' ORDER BY id DESC LIMIT 1), 'No, Charles Babbage, the inventor of the ‘Analytical Engine’, had already written a programme for it himself.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'mcq', 17, LAST_INSERT_ID());

-- Component 18 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Searching, exploring, being curious, developing a passion, pursuing one’s own interests – all these qualities defined Ada Lovelace. Education and support from others provided the fertile ground for this. Let us see how a talent unfolded – in the ‘dark’ Victorian 19th century.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Discover her biography' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'last message', 18, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE '), 2, 'Education', NULL, NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Education');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Education' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Ada Lovelace''s parents were as gifted as they were educated. Her mother was a MATHEMATICIAN, her father the then-famous POET Lord Byron. He was also known for his affinity for women. The marriage ended in divorce when Ada was one year old. She was eight when her father died. She never knew him. Her mother, Anna Isabella Noel Byron, particularly fostered Ada''s interest in mathematics, science, and technology. She was an EDUCATIONAL REFORMER and campaigned for the abolition of slavery. A certain free spirit shaped Ada and the atmosphere in which she grew up.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Education' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_text (content) VALUES ('Ada received PRIVATE LESSONS not only in French and music, but also in MATHMATICS AND NATURAL SCIENCES. In the 1840s, she was supported in her studies of ''higher mathematics'' by the mathematics professor at University College London, Augustus De Morgan, which also included the ''Bernoulli numbers'' that formed the basis for the algorithm she developed for Charles Babbage''s ''Analytical Engine''.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Education' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_text (content) VALUES ('Poetry was nevertheless important to her. Lovelace often questioned assumptions by connecting science and poetry. Moreover, she believed that INTUITION AND IMAGINATION were essential for developing mathematical and scientific concepts. Lovelace accorded METAPHYSICS equal importance to MATHMATICS and considered both equally "tools" for research and the acquisition of knowledge.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Education' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_quote (content, author) VALUES ('I may remark that the curious transformations many formulae can undergo, the unsuspected and to a beginner apparently impossible identity of forms exceedingly dissimilar at first sight, is I think one of the chief difficulties in the early part of mathematical studies. I am often reminded of certain sprites and fairies one reads of, who are at one''s elbows in one shape now, and the next minute in a form most dissimilar.', 'Ada Lovelace');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Education' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'quote', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('Ada_Lovelace Card 2 1838.jpg', 'Portrait Ada Lovelace', 'Ada Lovelace, appr. 1838');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Education' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'image', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_mcq (question) VALUES ('Were all children in 19th-century England provided with schooling?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Were all children in 19th-century England provided with schooling?' ORDER BY id DESC LIMIT 1), 'No, children could only receive private tuition.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Were all children in 19th-century England provided with schooling?' ORDER BY id DESC LIMIT 1), 'Yes, from 1880 onwards, school attendance was compulsory for all children up to the age of ten.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Were all children in 19th-century England provided with schooling?' ORDER BY id DESC LIMIT 1), 'Yes, even working-class children were able to attend Sunday school.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Were all children in 19th-century England provided with schooling?' ORDER BY id DESC LIMIT 1), 'Yes, except that school classes often had 200 pupils.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Education' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'mcq', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_last_messages (content) VALUES ('Let us now take a closer look at her intellectual passion.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Education' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE '), 3, 'Mathmatics and computer science', NULL, NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('Mathmatics and computer science');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Ada Lovelace developed the ability for structured scientific work at an early age. At twelve years old, she developed a steam-powered ''FLYING MASHINE'' and wrote about the ''science'' of ‘FLIGHTOLOGY''.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_text (content) VALUES ('The collaboration with CHARLES BABBAGE proved formative. He was working on the ‘ANALYTICAL MASHINE’, a kind of calculating machine. However, the project was never completed. Ada Lovelace recognized the potential of such a machine and saw the possibility of "programming" using both numbers and symbols. The Italian mathematician Luigi Menabrea had described the ‘Analytical Machine’. In 1843, Ada Lovelace translated the text and supplemented it with her own considerations and calculations for building such a machine.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_text (content) VALUES ('She outlined a plan for how to calculate Bernoulli numbers using this "Analytical Machine." Such instructions or plans can also be called ALGORHITMS. Therefore, Ada Lovelance was considered the person who wrote the first published computer programme.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_text (content) VALUES ('Babbage developed the Analytical Engine to make it easier to calculate tables of numbers. These were intended to advance science and engineering. Lovelace took this idea further. She envisioned that the machine could also combine LETTERS and compose MUSIC, since sequences of notes could be ''translated'' into numerical combinations.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_text (content) VALUES ('At the same time, Ada Lovelace reflected on the methods of scientific inquiry themselves and demonstrated an interest in EPISTEMOLOGY.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_quote (content, author) VALUES ('„The Analytical Engine weaves algebraic patterns, just as the Jacquard loom weaves flowers and leaves.“', 'Ada Lovelace');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'quote', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('Ada_Lovelace Card 3.jpg', NULL, NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'image', 8, LAST_INSERT_ID());

-- Component 9 for Card 3
INSERT INTO component_open_questions (question) VALUES ('How do you get on with maths? What do you need numbers for?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'open question', 9, LAST_INSERT_ID());

-- Component 10 for Card 3
INSERT INTO component_last_messages (content) VALUES ('Little is known about it, but Ada Lovelace also had an interest in the arts. Find out more on the next card.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Mathmatics and computer science' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'last message', 10, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE '), 4, 'Music and poetry', NULL, NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Music and poetry');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Music and poetry' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('A painting by Henry Wyndham Phillips from 1852 depicts Ada Lovelace PLAYING THE PIANO. She had received music lessons as a child. She was also said to have played THE HARP and sung with great enthusiasm.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Music and poetry' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_text (content) VALUES ('Did the development of her analytical skills and the cultivation of her creative side mutually and positively influence each other? When Ada Lovelace sought to combine mathematics and poetry, observations of everyday life and scientific modeling, it reveals a consideration of reality that was evidently broader than that of her contemporaries. Could this be a source of her genius?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Music and poetry' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_quote (content, author) VALUES ('„Mathematics reveals what is. It is the language of the invisible relationships between things. But in order to use and apply this language, we must be able to appreciate and sense the invisible, the unconscious.“', 'Ada Lovelace');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Music and poetry' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('Ada_Lovelace Card 4.jpg', 'Ada Lovelace', 'Ada Lovelace playing piano, 1852');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Music and poetry' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'image', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_open_questions (question) VALUES ('What are your interests and passions? How do you reconcile the differences?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Music and poetry' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_last_messages (content) VALUES ('Let us now ask whether and how it was possible for a woman in 19th-century England to be both a mother and a mathematician.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Music and poetry' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE '), 5, 'Female scientist in 19th century', NULL, NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('Female scientist in 19th century');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Female scientist in 19th century' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Although Ada Lovelace lived in a privileged and secure environment, her life was also shaped by the PATRIARCHAL CONDITIONS of the 19th century. Hardly imaginable today, but at that time women had NO RIGHT to vote, could not study, could not decide about pregnancies, had limited access to employment, were expected to toil hard as factory workers, and kindergartens were unthinkable.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Female scientist in 19th century' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_text (content) VALUES ('Ada Lovelace suffered from the fact that marriage, household chores, and her three children consumed so much of her time that she had LITTLE OPPORTUNITY for scholarly work. Music also suffered. She longed for RECOGNITION of her intellectual abilities from friends and family. She distracted herself with love affairs and horse racing. From 1843 onward, she suffered intermittently from anorexia and bouts of depression, and increasingly consumed brandy and opium. HER CHILDREN were taken from her and subsequently raised by their grandmother. Nine years later, she died at the age of only 36.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Female scientist in 19th century' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_quote (content, author) VALUES ('“If you knew even half the extraordinary, reckless things I do, you would surely be inclined to think that some kind of spell has been cast upon me.”', 'Ada Lovelace');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Female scientist in 19th century' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('Wissenschaft 19. Jh. Flammarion - Card 5.jpg', 'Man beholds the new world view beyond the celestial spheres', 'Flammarion’s woodcut (1888): Man beholds the new world view beyond the celestial spheres');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Female scientist in 19th century' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'image', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_mcq (question) VALUES ('Over the past few decades, the situation of women has improved compared to the 19th century. What made this possible? Through …');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Over the past few decades, the situation of women has improved compared to the 19th century. What made this possible? Through …' ORDER BY id DESC LIMIT 1), '… the Catholic church');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Over the past few decades, the situation of women has improved compared to the 19th century. What made this possible? Through …' ORDER BY id DESC LIMIT 1), '… social crises (after 1918) and the competition between political systems (1945–1989)?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Over the past few decades, the situation of women has improved compared to the 19th century. What made this possible? Through …' ORDER BY id DESC LIMIT 1), '… the women’s movement and a critical public');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Over the past few decades, the situation of women has improved compared to the 19th century. What made this possible? Through …' ORDER BY id DESC LIMIT 1), '… improved surveillance methods');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Female scientist in 19th century' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_last_messages (content) VALUES ('The recognition that Ada Lovelace lacked during her lifetime is now being bestowed upon her. How? Swipe to find out...');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Female scientist in 19th century' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE '), 6, 'Reception', NULL, NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Reception');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reception' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('Ada Lovelace died alone and WITHOUT RECOGNITION of her extraordinary abilities. It would be more than 100 years before she received widespread social recognition. She herself believed in herself:');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reception' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_text (content) VALUES ('“That brain of mine is something more than merely mortal… As time will show.”');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reception' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_text (content) VALUES ('In 1975, the US Department of Defense named the programming language ADA after her. There are now streets named after her, an Ada Lovelace Prize, an Ada Lovelace Project to promote women in STEM fields, a children''s book series, and novels about her life and work. Even an asteroid is named after her.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reception' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_quote (content, author) VALUES ('“If you knew even half the extraordinary, reckless things I do, you would surely be inclined to think that some kind of spell has been cast upon me.”', 'Ada Lovelace');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reception' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'quote', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_image (image_url, image_alt, image_description) VALUES ('Ada_Lovelace Card 6.png', 'Ada Lovelace', 'Ada Lovelace');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reception' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'image', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_open_questions (question) VALUES ('What makes Ada Lovelace interesting to you today?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reception' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 6
INSERT INTO component_last_messages (content) VALUES ('We’ve arrived! It’s great that you’ve joined us. Next day, we continue with a character who’s particularly good at one thing: listening.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Reception' AND owner_id = (SELECT id FROM module WHERE title = 'Pioneer of Computer Science - ADA LOVELACE ') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
