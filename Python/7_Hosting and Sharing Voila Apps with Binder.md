##  Hosting and Sharing Voila Apps with Binder

Ok, so you have an app, congratulations! The next step is to share it. Luckily, that's a relatively easy process, thanks to online tools like Binder. 

Binder is a free online computing service which allows you to host jupyter notebooks as interactable webpages. It is, in fact, what has been powering this course if you have used the interactive coding environment available on these pages. 

All you need to do is host your notebook, a requirements, and a config file in a github repository, and then use the binder service to set up an interactive web app using voila. 


In the repository for this class, in the Python folder there should be three files and directory
1. config.whatever
2. environment.yaml
3. voila_demo.ipynb
4. Data/

Copy all of these to a new directory and create a new github repository. If you have not done this before, the easiest way is to download [GitHub Desktop](https://desktop.github.com), initalize a new repository, and push your files to GitHub. Once you have done this, make sure your repository is public and navigate to its webpage on your profile. 

Once you have done this, in a new tab navigate to https://mybinder.org, and paste the url to your github repository in the top input box. In the 'path to a notebook file' box, use the dropdown on the right to select 'URL' instead of 'File' and paste /VOILA/voila_demo.ipynb to ensure the service opens your notebook in voila. 

Click Launch, and wait. After a few minutes, your app should be usable! 

Congratulations, you have built and deployed a geospatial web app in Python. You can share the URL to your binder with anyone in order to share the results with others. We have built a very basic app together, and there are many more possibilities and functions which you are able to develop, especially if you also learn HTML or Javascript, I encourage you to explore the other options available and use what you have learned in order to create apps which showcase your own research, this is just the beginning! 