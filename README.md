## Sources

Naval News  
https://www.navalnews.com/?s=china+chinese  
Solely focused on providing factual reporting on naval related news, cites official Government sources.

NOSI – Naval Open Source Intelligence  
https://nosi.org/category/chinesenavy/  
NOSI Provides a large amount of open source intelligence information for everything Naval related, additionally they also cite governments reports.

CMSI China Maritime Reports  
https://digital-commons.usnwc.edu/cmsi-maritime-reports  
USNWC China Maritime Reports are highly credible due to being published by the U.S. Naval War College.

## Workflow Structure

This workflow scrapes content from several websites, breaks the text into chunks using the recursive text splitter, and then turns those chunks into embeddings. Those embeddings get stored in the in-memory vector store so the system can reference them. A retrieval QA chain then pulls the most relevant chunks when a user asks a question and provides details for the response prompt along with rephrasing the current prompt into a standalone question. Finally, the ChatOpenAI model (in this case llama3) is set to JSON mode..

## Caveats given time constraint

The largest issue is the scraping can vary (403s, and alike) and may not produce consitent results.  
Tagging and sentiment analysis is all done within the context window. Web scraping parsing could be done more efficiently. Separation between sources is not distinguishable in output.  
Another major caveat is the data that I am parsing does not contain all of the info I am attempting to extract causing some level of hallucination, this was somewhat mitigated using the system prompt.  
Vector store is in-memory so data will be lost on restart causing horizontal scaling issues.

## Instructions for running

Assuming you are running on Linux (and do not have any of these tools pre-installed) and are you node v20 run install.sh located in the src directory  
Caveat: given the time constraint I did not dockerize. Ideally I would do this. Additionally the flowise loading would be completely automated.

Open localhost:3000 (the default for flowise) and then create an account.  
Create a new chatflow, click the settings cog, load chatflow, and then select the json file from the src directory.

Hit the save icon and run the following curl command to actually trigger the chatflow.

```bash
curl http://localhost:3000/api/v1/prediction/a10ac068-7761-4f1f-9a65-9d5ff3ca03a0 \
     -X POST \
     -d '{"input": "list"}' \
     -H "Content-Type: application/json"
```

When working correctly all inputs will return a json like 

```json
{
  "int_type": ["OSINT"],
  "ship_class": "Type 052D Luyang III-class destroyer",
  "weapon_systems": ["HHQ-9 SAM", "YJ-18A cruise missile", "730 CIWS"],
  "date": ["2025-08-11"],
  "location": ["East China Sea"],
  "sentiment": "neutral",
  "reliability": 4,
}

```
