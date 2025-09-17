# %%
# -*- coding: utf-8 -*-

"""
Spyder Editor

"""

'''
https://community.openai.com/t/which-api-for-translation/553000/6
GPT3.5
I translated recently a large document, close to 4000 pages (in chunks of about 8 pages per API call, it ran for 11 hours), from English into Spanish, using gpt3.5, and I was very satisfied with the result.

According to our findings, about 75% of the translations were accurate. However, in the context of running an online business, the difference between 75% and 100% can be the difference between making a sale and losing a customer’s interest, as they can immediately tell if the translation is not professional. AI-generated translations should always be paired with human quality assurance. In fact, we have introduced a separate service that offers just that—human reviewers for AI-translated content, for companies that want to leverage AI but need their content to be flawless.

'''


'''
https://community.openai.com/t/does-the-api-for-translations-actually-translate/733078/2
I’ve got a simple spoken audio to text interface working, using Python and the async version of OpenAI official python library.

It works great for spoken English, but does not translate any non-English to English.

The OpenAI API documentation says it translates non-English to English and lists a large series of languages. I see people posting apps where they say they are calling the OpenAI API for their translations.

I’ve seen posts where people describe doing this using curl, and using a v1 url to whisper-1, but I cannot describe this anymore without this moderation system claiming I’m trying to hide a link in my post.

How is anyone achieving translation? I’ve tried using the optional prompt, tried the ‘language=“en”’ optional parameter. It always transcribes into the original language and does not translate to English. How to trigger the translation? Does anyone have this working through the OpenAI API and not Whisper running locally?

transcript = openai.audio.transcriptions.create(model=“whisper-1”, file=audio_file)

translation = openai.audio.translations.create( model =“whisper-1”,
file= audio_file,
temperature = 0.90)

For english audio to english text, I use transcriptions.

For non-english to english, I use translation. The list of languages available is listed in the documentation for whisper. The system auto-detects the language and it is not necessary to set a variable.
'''


'''
https://transcy.crisp.help/en/article/how-to-use-openai-translation-vni6lx/

https://platform.openai.com/docs/quickstart

'''


'''
USE THIS!!
