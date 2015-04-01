import json
import pandas as pd
import requests
 
# Your API key goes here.
API_KEY = ''
 
raw_df = pd.read_csv('linkedin-sf.csv', encoding='utf-8', skiprows=1,
                     error_bad_lines=False)
 
df = raw_df[['text_1', 'title_link/_text', 'snippet_text']]
df.columns = ['location', 'title', 'description']
 
content_df = list(df.title + ' ' + df.description)
 
categories = []
step = 150
for start in xrange(0, len(content_df), step):
    end = start + step
 
    response = requests.post(
        "https://api.monkeylearn.com/api/v1/categorizer/cl_4PFzSWVR/classify_batch_text/",
        data=json.dumps({
            'text_list': content_df[start:end]
        }),
        headers={
            'Authorization': 'Token {}'.format(API_KEY),
            'Content-Type': 'application/json'
        }
    ).json()
 
    # We go through the results of the API call, storing the result on a list.
    for category in response['result']:
        categories.append(category[0]['label'])
 
augmented_df = df.join(pd.DataFrame(categories, columns=['category']))
augmented_df.to_csv('linkedin-sf-aug.csv', encoding='utf-8',
                    index=False, header=False)