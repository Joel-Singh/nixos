= Denison Library PDF Remediation Project

Need to make sure to use dotenv for my api key...

- Node project in order to use puppeteer (is also a quick and dirty script for initial prototype)
- Pass in a url and then it:
  - downloads with httptrack 
  - looks for an index.html file
  - Finds all images, creates alt tags for them, and then inserts it into the file
  - Take pdf download with puppeteer (hopefully the alt tag is in the pdf?)

https://dri.es/automating-alt-text-generation-ai
https://dri.es/comparing-local-llms-for-alt-text-generation

Going to modify the above to not use httrack:

- Pass in a url and then it:
  - opens the page with puppeteer
  - modifies the HTML img tags as necessary
  - 
