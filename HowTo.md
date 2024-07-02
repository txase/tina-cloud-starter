### How to update favicon

Favicons are the little icon next to the title of the page

1. First download a png of the favicon you want
2. Open the public folder and right click the images folder inside
3. There should be an option that says Upload...
4. Click that and upload your file
5. Delete the old favicon file and rename your new one to "favicon.png"

### How to make a new page

1. Go to the menu.json file 
2. add this to the end of the main area
        {
          "name": "Your Page",
          "url": "/your-page"
        }
3. Make sure the url ending has no capitals
4. In the content folder there should be a folder called pages
5. In the pages folder create a new .md file and make sure it this at the top
    ---
    title: "Your Page title"
    description: "your pages description"
    draft: false
    ---
6. Then add all your text underneath