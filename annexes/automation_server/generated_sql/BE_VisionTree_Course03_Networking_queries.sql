-- ============================================
-- SQL Queries Generated on 2026-08-23 19:54:06.500348
-- ============================================
-- These queries can be copied and executed directly
-- Subqueries are used to automatically resolve IDs
-- ============================================


-- ============================================
-- Course: Networking: Building Real, Warm Connections
-- ============================================

-- Category: Connection & Community
-- Check/Create category 'Connection & Community'
INSERT IGNORE INTO module_category (title, description, created_at) VALUES ('Connection & Community', 'test description', '2026-08-23 19:54:06.498990');

-- Module creation with automatic category lookup
INSERT INTO module (module_category_id, day_number, title, description, target_audience, estimated_duration, created_at) VALUES ((SELECT id FROM module_category WHERE title = 'Connection & Community'), 20, 'Networking: Building Real, Warm Connections', 'Learn how to build a small, warm, useful network through honest conversations — online and in person — without performing.', 'Women learners (18+), introverts and extroverts', 15, '2026-08-23 19:54:06.498997');

-- ============================================
-- Card 1
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections'), 1, 'Networking is not a performance. It is a relationship.', 'How do you currently feel about the word ‘networking’?', NULL, NULL);

-- Component 1 for Card 1
INSERT INTO component_title (content) VALUES ('Networking is not a performance. It is a relationship.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Networking is not a performance. It is a relationship.' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 1
INSERT INTO component_text (content) VALUES ('Many women carry a bad definition of networking. It sounds like standing in a room with a glass of wine, forcing small talk, handing out business cards, and pretending to be more important than you are. No wonder it feels exhausting. A better definition, and the one we’ll use for the rest of this course, is simpler: networking is building a small group of people who remember you kindly and think of you when an opportunity comes up.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Networking is not a performance. It is a relationship.' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 1
INSERT INTO component_quote (content, author) VALUES ('You don’t need a thousand contacts. You need thirty people who remember you kindly.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Networking is not a performance. It is a relationship.' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 1
INSERT INTO component_text (content) VALUES ('You also don’t need to be extroverted. Introverts often build stronger networks than extroverts, because they tend to have fewer but deeper one-to-one conversations. What matters is not energy level — it’s whether the other person walks away thinking ‘I liked her’ and ‘I learned something’. That is a skill, and this course will give you the tools to do it on purpose.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Networking is not a performance. It is a relationship.' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 1
INSERT INTO component_subtitle (content) VALUES ('How do you currently feel about the word ‘networking’?');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Networking is not a performance. It is a relationship.' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 1
INSERT INTO component_open_questions (question) VALUES ('Think of one person in your professional or personal network who has genuinely helped you. What did they do that made you trust them? Write 2–3 sentences.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Networking is not a performance. It is a relationship.' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 1
INSERT INTO component_last_messages (content) VALUES ('Keep that person in mind. By the end of this course, you’ll know how to be that person for someone else.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Networking is not a performance. It is a relationship.' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 2
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections'), 2, 'Before the room: prepare three small things', 'Why this works', NULL, NULL);

-- Component 1 for Card 2
INSERT INTO component_title (content) VALUES ('Before the room: prepare three small things');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Before the room: prepare three small things' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 2
INSERT INTO component_text (content) VALUES ('Most networking anxiety comes from one specific fear: ‘I won’t know what to say.’ That fear disappears with 10 minutes of preparation. Before any event, coffee, online call or conference, prepare three small things. You’ll walk in calmer, and you’ll sound clearer.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Before the room: prepare three small things' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 2
INSERT INTO component_subtitle (content) VALUES ('The three-question prep');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Before the room: prepare three small things' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 2
INSERT INTO component_subtitle (content) VALUES ('Why this works');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Before the room: prepare three small things' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 2
INSERT INTO component_text (content) VALUES ('The first answer stops you sounding like a LinkedIn bio. The second gives you real questions to ask other people (which is the actual secret of being liked in a conversation). The third makes you memorable, because almost no one walks in thinking ‘what can I offer?’ — everyone else is thinking ‘what can I get?’. You stand out just by reversing the question.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Before the room: prepare three small things' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 5, LAST_INSERT_ID());

-- Component 6 for Card 2
INSERT INTO component_quote (content, author) VALUES ('You don’t have to be the most interesting person in the room. You have to be genuinely interested in one person.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Before the room: prepare three small things' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'quote', 6, LAST_INSERT_ID());

-- Component 7 for Card 2
INSERT INTO component_open_questions (question) VALUES ('Do the three-question prep for yourself right now. Write your three answers in one or two sentences each.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Before the room: prepare three small things' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 2
INSERT INTO component_last_messages (content) VALUES ('You just did more networking preparation than 90% of the people in any room.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Before the room: prepare three small things' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 3
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections'), 3, 'In the conversation: ask, don’t sell', 'How to leave a conversation kindly', NULL, NULL);

-- Component 1 for Card 3
INSERT INTO component_title (content) VALUES ('In the conversation: ask, don’t sell');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'In the conversation: ask, don’t sell' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 3
INSERT INTO component_text (content) VALUES ('Most people network by talking about themselves. If you do the opposite, you’ll stand out without trying. Three small techniques do almost all the work: ask better opening questions, listen with follow-ups, and know how to leave a conversation kindly.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'In the conversation: ask, don’t sell' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 3
INSERT INTO component_subtitle (content) VALUES ('Openers that actually work (instead of ‘so, what do you do?’)');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'In the conversation: ask, don’t sell' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 3
INSERT INTO component_subtitle (content) VALUES ('How to leave a conversation kindly');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'In the conversation: ask, don’t sell' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 4, LAST_INSERT_ID());

-- Component 5 for Card 3
INSERT INTO component_mcq (question) VALUES ('You’ve been stuck in a conversation with someone for 15 minutes and want to meet other people. What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been stuck in a conversation with someone for 15 minutes and want to meet other people. What do you do?' ORDER BY id DESC LIMIT 1), 'Keep nodding politely and hope they leave first (and feel drained for the rest of the event).');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been stuck in a conversation with someone for 15 minutes and want to meet other people. What do you do?' ORDER BY id DESC LIMIT 1), 'Say ‘I’ve loved talking with you — I want to let you meet other people here too’ and step away warmly.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You’ve been stuck in a conversation with someone for 15 minutes and want to meet other people. What do you do?' ORDER BY id DESC LIMIT 1), 'Invent a fake phone call and disappear.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'In the conversation: ask, don’t sell' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 3
INSERT INTO component_quote (content, author) VALUES ('People will forget what you said. They will remember how you listened.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'In the conversation: ask, don’t sell' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'quote', 6, LAST_INSERT_ID());

-- Component 7 for Card 3
INSERT INTO component_open_questions (question) VALUES ('Which opener from the list above feels most like something you could actually say? Write it down in your own words.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'In the conversation: ask, don’t sell' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 3
INSERT INTO component_last_messages (content) VALUES ('A kind exit protects your energy. You are not rude for leaving a conversation — you are responsible for yourself.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'In the conversation: ask, don’t sell' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 4
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections'), 4, 'Online networking: warm messages, not cold ones', 'Things to avoid', NULL, NULL);

-- Component 1 for Card 4
INSERT INTO component_title (content) VALUES ('Online networking: warm messages, not cold ones');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Online networking: warm messages, not cold ones' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 4
INSERT INTO component_text (content) VALUES ('Most LinkedIn messages fail for one reason: they are not actually about the person you’re writing to. They are about you. The fix is simple — lead with something specific about them, then say clearly what you want, in 3–5 sentences. No essays. No flattery. Just warmth and honesty.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Online networking: warm messages, not cold ones' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 4
INSERT INTO component_subtitle (content) VALUES ('A message structure that actually works');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Online networking: warm messages, not cold ones' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 4
INSERT INTO component_quote (content, author) VALUES ('Cold is not the opposite of polite. Warm is specific.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Online networking: warm messages, not cold ones' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 4
INSERT INTO component_subtitle (content) VALUES ('Things to avoid');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Online networking: warm messages, not cold ones' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 4
INSERT INTO component_open_questions (question) VALUES ('Pick one person you’ve wanted to reach out to online. Draft the four-sentence message right now — don’t send it yet, just draft it.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Online networking: warm messages, not cold ones' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 4
INSERT INTO component_last_messages (content) VALUES ('A specific, honest four-sentence message gets more replies than a long, generic one. Every time.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Online networking: warm messages, not cold ones' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- Card 5
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections'), 5, 'After the first meeting: the follow-up most people skip', 'A 48-hour follow-up template', NULL, NULL);

-- Component 1 for Card 5
INSERT INTO component_title (content) VALUES ('After the first meeting: the follow-up most people skip');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'After the first meeting: the follow-up most people skip' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 5
INSERT INTO component_text (content) VALUES ('Here is the single biggest differentiator in networking — and it is almost embarrassing how simple it is. Most people do not follow up. They meet someone interesting, exchange contacts, and then never say another word. The small group who do follow up, even briefly, end up remembered and trusted. You can be in that group with one short message, within 48 hours.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'After the first meeting: the follow-up most people skip' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 5
INSERT INTO component_quote (content, author) VALUES ('Networking isn’t the first conversation. It’s the second one.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'After the first meeting: the follow-up most people skip' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'quote', 3, LAST_INSERT_ID());

-- Component 4 for Card 5
INSERT INTO component_text (content) VALUES ('The follow-up doesn’t need to be clever. It needs to be timely (within 48 hours), specific (mention one thing from your conversation), and small (no big requests yet). After that, a gentle touch every few months is enough to keep a relationship alive — a relevant article, a congratulations on a post, an honest ‘thought of you when I saw this’.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'After the first meeting: the follow-up most people skip' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 4, LAST_INSERT_ID());

-- Component 5 for Card 5
INSERT INTO component_subtitle (content) VALUES ('A 48-hour follow-up template');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'After the first meeting: the follow-up most people skip' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 5, LAST_INSERT_ID());

-- Component 6 for Card 5
INSERT INTO component_mcq (question) VALUES ('You had a great coffee with someone interesting two days ago. You keep meaning to write and never do. What do you do?');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You had a great coffee with someone interesting two days ago. You keep meaning to write and never do. What do you do?' ORDER BY id DESC LIMIT 1), 'Keep waiting until you have ‘something clever’ to say, and never send anything.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You had a great coffee with someone interesting two days ago. You keep meaning to write and never do. What do you do?' ORDER BY id DESC LIMIT 1), 'Send a three-sentence thank-you message today — warm, specific, no big ask.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'You had a great coffee with someone interesting two days ago. You keep meaning to write and never do. What do you do?' ORDER BY id DESC LIMIT 1), 'Send a long message apologising for the delay and explaining your week.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'After the first meeting: the follow-up most people skip' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'mcq', 6, LAST_INSERT_ID());

-- Component 7 for Card 5
INSERT INTO component_open_questions (question) VALUES ('Is there someone you met in the last 2 months that you never followed up with? Write their name down. Then write a draft three-sentence message to them — you don’t have to send it today.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'After the first meeting: the follow-up most people skip' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'open question', 7, LAST_INSERT_ID());

-- Component 8 for Card 5
INSERT INTO component_last_messages (content) VALUES ('The follow-up is the relationship. The first conversation is just the beginning.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'After the first meeting: the follow-up most people skip' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'last message', 8, LAST_INSERT_ID());

-- ============================================
-- Card 6
-- ============================================
INSERT INTO card (owner_type, owner_id, card_order_index, title, subtitle, end_text, why_this_question) VALUES ('module', (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections'), 6, 'Your networking toolkit', 'Pick the right tool for the right moment', NULL, NULL);

-- Component 1 for Card 6
INSERT INTO component_title (content) VALUES ('Your networking toolkit');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your networking toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'title', 1, LAST_INSERT_ID());

-- Component 2 for Card 6
INSERT INTO component_text (content) VALUES ('You don’t have to like networking. You just have to have a small, honest way of doing it. What you built in this course is exactly that — a quiet, repeatable method that works whether you’re introverted, new to your field, or tired of feeling transactional.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your networking toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'text', 2, LAST_INSERT_ID());

-- Component 3 for Card 6
INSERT INTO component_subtitle (content) VALUES ('Pick the right tool for the right moment');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your networking toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'subtitle', 3, LAST_INSERT_ID());

-- Component 4 for Card 6
INSERT INTO component_quote (content, author) VALUES ('A small network of people who trust you is worth more than a large one that doesn’t.', NULL);
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your networking toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'quote', 4, LAST_INSERT_ID());

-- Component 5 for Card 6
INSERT INTO component_mcq (question) VALUES ('Pick the one you want to practice first this week.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the one you want to practice first this week.' ORDER BY id DESC LIMIT 1), 'Write the four-sentence warm message to someone I’ve been postponing.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the one you want to practice first this week.' ORDER BY id DESC LIMIT 1), 'Send a 48-hour follow-up to someone I met recently.');
INSERT INTO multiple_choices_options (mcq_id, option_text) VALUES ((SELECT id FROM component_mcq WHERE question = 'Pick the one you want to practice first this week.' ORDER BY id DESC LIMIT 1), 'Do the three-question prep before my next meeting or event.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your networking toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'mcq', 5, LAST_INSERT_ID());

-- Component 6 for Card 6
INSERT INTO component_open_questions (question) VALUES ('Write one sentence that starts with ‘This week, I will…’ — name the person, the technique and when you will do it. Keep it small enough that you can actually keep the promise.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your networking toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'open question', 6, LAST_INSERT_ID());

-- Component 7 for Card 6
INSERT INTO component_last_messages (content) VALUES ('Networking is not about meeting more people. It’s about being someone one person is glad they met.');
INSERT INTO card_contains (card_id, component_type, component_order_index, component_id) VALUES ((SELECT id FROM card WHERE title = 'Your networking toolkit' AND owner_id = (SELECT id FROM module WHERE title = 'Networking: Building Real, Warm Connections') LIMIT 1), 'last message', 7, LAST_INSERT_ID());

-- ============================================
-- End of generated queries
-- ============================================
