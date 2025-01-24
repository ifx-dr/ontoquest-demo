# Introduction

## Description

**OntoQuest** is a *vocabulary management game* tailored to address the nuanced terminologies and vocabulary within **Infineon Technologies**. With diverse coverage across *Automotive*, *Green Industrial Power*, *Power & Sensor Systems*, and *Connected Secure Systems*, understanding the comprehensive vocabulary becomes a challenge. The game ensures domain-specific vocabulary definitions and terminology standardization, mitigating misunderstandings stemming from multiple meanings of the same words and discrepancies in cross-departmental communication.

## Process
The game's process begins with **domain or department selection**, followed by **ontology selection** and **question quantity**. Users engage in validating vocabulary *definitions*, presenting terms and their definitions, with options to **agree**, **disagree**, or express uncertainty. The completed definitions and *contribution scores* are summarized. The scoring system weighs agreement based on **previous agreements** and **community consensus**, while **disagreement** scoring accounts for *semantic differences*. The stability system utilizes *semantic similarity calculations*, dynamic stability thresholds based on **total reviews**, and **clustering** to consolidate definitions, ensuring coherence and consistency.

## Files Structure

- VOCAB GAME
    - .idea  *(IDE-specific directory for project settings and configurations)*
    - __pycache__
    - FLASK
        - instance  *(Flask instance folder for configuration files)*
        - website
            - static  *(Contains static assets such as CSS, JSON, images, and ontologies)*
                - css
                - json
                - ontologies  *(File to store the ontologies of the game as rdf file)*
                - picture *(File to store particularly the ontologies pictures in 600x338 size)*
            - templates  *(Stores the HTML templates for the website)*
            - __init__.py  *(Initialization script for the Flask application)*
            - auth.py  *(Manages user authentication routes)*
            - challenges.py  *(Manages the challenges of the game)*
            - manage_db.py  *(Manages the database)*
            - models.py  *(Defines the table models for the database)*
            - definition_score.py  *(Manages the definition score and stability system)*
            - views.py  *(Manages the routes and views of the game)*
            - database.db  *(SQLite database file to store the table and database of the game)*
        - main.py  *(Executable script to run the game)*




# Usage

## Prerequisites

The following libraries and packages are required for the project: 
- [nltk](https://pypi.org/project/nltk/) 
- [gensim](https://pypi.org/project/gensim/) 
- [flask](https://pypi.org/project/Flask/)
- [flask login](https://pypi.org/project/Flask-Login/)
- [owlready2](https://pypi.org/project/Owlready2/) 
- [numpy](https://pypi.org/project/numpy/) 
- [scikit-learn](https://pypi.org/project/scikit-learn/) 
- [networkx](https://pypi.org/project/networkx/) 
- [flask sqlalchemy](https://pypi.org/project/Flask-SQLAlchemy/)
- [rdflib](https://pypi.org/project/rdflib/4.0/)
- [SQL Alchemy](https://pypi.org/project/SQLAlchemy/)
- [Werkzeug](https://pypi.org/project/Werkzeug/)

To install and set up the project, ensure that the mentioned libraries and packages are installed. You can easily install them using pip and the provided requirements.txt file:
```
pip install -r requirements.txt
```

## Installation

To run the game, follow these steps: 
1.  **Clone the Repository**: 
	- Clone the OntoQuest repository to your local machine using Git or download it: 
```
git clone https://github.com/NilsBarInf/OntoQuest.git 
```
2. **Navigate to the Flask Folder**: 
	- Navigate to the 'FLASK' directory in the cloned repository: 
```
cd VOCAB GAME/FLASK
``` 
3.  **Start the Game**: 
	- Open the `main.py` file and execute it to start the game: ``` python main.py ``` 
4.  **Access the Game**: 
	- Once the game is running, click on the HTTP address that appears in the terminal to open the game in a web browser. By following these steps, you can easily set up and start playing the OntoQuest game.
	
## Configuration

The project is currently in debug mode, but this can be deactivated by replacing the configuration with `debug=False` in the `main.py` file.

## Database Setup

All the **table models** are created in the `models.py` file and stored in the `database.db` file. To **add a new table** to the database, create one in the `models.py` file, and it will be automatically created and added to the database when launching the game. To **add a new column**, delete the entire table from the database, add the column to the table in the `models.py` file, and launch the game to recreate the table with the added column. To **access the database**, use [DB Browser for SQLite](https://sqlitebrowser.org/).

# Introduction to Flask
[Flask](https://pymbook.readthedocs.io/en/latest/flask.html) is a web framework for Python, known for its simplicity and flexibility. It facilitates the creation of web applications and RESTful APIs. In OntoQuest, Flask is used to handle web requests, render HTML templates, and serve static assets such as CSS and JavaScript.

## Route/Page
To add a new route/page in Flask, you can define a new function with the `@views.route` decorator in the `views.py` file. This function will handle HTTP requests for a specific URL path and return the corresponding response.

*Example: Adding a New Page and Linking it to HTML*
```
@views.route('/new-page', methods=['GET'])
def new_page():
    return render_template('new_page.html')
```

## HTML 
In Flask, you can use the `render_template` (see previous example) function to render HTML templates. This function takes the name of the HTML template as an argument and renders the template with any necessary context data. In a Flask application, an HTML template is a file that contains the structure and content of a web page. It allows you to dynamically generate HTML by inserting data from your Python code into the template.

*Example: HTML Template*
```
{% extends "base.html" %}
<!-- This template extends a base template, allowing you to reuse common HTML structure and styling
	across multiple pages.  -->

{% block title %}New Page{% endblock %} <!-- Your Page Title Here -->

{% block styles %}
    <!-- Link to your custom CSS file or any other code for the style of your HTML page -->
    <link rel="stylesheet" type="text/css" href="{{ url_for('static', filename='css/your-styles.css') }}">
{% endblock %}

{% block content %}
    <!-- Content specific to your page -->
                <!-- Example of Python loop to generate range of values -->
                {% for i in range(0, 11) %}
                    <span>{{ i*5 }}</span>
                {% endfor %}
{% endblock %}
```

## Creation Guidelines
When creating a new route/page, you need to create the corresponding HTML and CSS files. The HTML file should be placed in the `templates` directory, and the CSS file should be placed in the `static/css` directory. This ensures that Flask can locate and serve these files correctly.

# Ontologies Management

## Ontologies File Structure
When adding an ontology to the game, store the RDF file in the `ontologies` directory, which is a subdirectory of the `static` file. Currently, only RDF file types are supported.

## Ontology Format Guidelines
To ensure compatibility, follow these guidelines when creating or editing ontologies:

- Each term should be represented as a class.
- Define each term's definition as an annotation, specifically a comment, associated with the corresponding class.
- The additional information provided by the users are stored with data properties that are the following one:
	- hasAbbreviation
	- hasAlternativeName
	- hasExample
	- hasGermanName
   
## Database Configuration
In addition to adding the ontology file, you need to register the ontology in the database. You can do this using a database browser or by running the necessary SQL commands.

### Ontology Table
Add a new row to the `ontology` table with the following information:
- name: The name of the ontology
- description: A brief description of the ontology
- image_url: The URL to the corresponding image of the ontology, in the format `picture/ontologies_pictures/name_of_image.jpg` (or .png) and add the image in the `ontologies_pictures` directory (subdirectory of the `picture` file)
- ontology_url: The name of your ontology file, in the format `name_of_ontology.rdf`

### Department-Ontology Association
To associate the ontology with the relevant departments, add the necessary rows to the `department_ontology_association` table with the following information:
- department: The name of the department
- ontology_id: The ID of the ontology you previously added to the ontology table

## Updating Departments

When adding or modifying an existing department, you need to update the `department_ontology_association` table accordingly. Additionally, you need to update the `department.html` file by adding or modifying the following code in the select section with the department's name that you entered in the DB as value:

```
<option value="name_of_department_entered_in_db">Name of Department</option>
```

By following these steps, you can successfully add an ontology to the game and make it playable for the associated departments.

# Additional Information

## Things Not Currently Implemented

-   Incentives such as challenges and badges

## Improvements that need to be conceptualized/implemented:
### Determine user knowledge level:
- Use a short quiz or a series of questions at the beginning to determine the user's knowledge level in a particular area of interest (for this we can use the definition of the DR)
- Use the user's answers to determine their level of expertise, e.g., beginner, intermediate, advanced
- Use this information to tailor the game experience to the user's level

### "Area of interest" instead of "department":
- Use "area of interest" as a more general term to encompass different domains and expertise areas
- Allow users to select multiple areas of interest to reflect their diverse expertise and interests
- Default areas of interest can be based on the DR lobes

### Defining a "correct" answer:
- Establish a set of criteria to determine what constitutes a "correct" answer for the definitions, e.g., accuracy, relevance, completeness

### Creating an "expert" community:
- Establish a threshold for becoming an "expert" in a particular area of interest, e.g., top 5% of users with at least 100 correct answers
- Provide incentives for users to become experts, e.g., badges, special privileges, recognition on a leaderboard
- Only allow experts to contribute additional information on the terms of the ontologies
- Implement a system to remove users from the expert community if their performance falls below a certain threshold, e.g., 10%

### Making recent answers more "important":
- Use a weighted scoring system to give more importance to recent answers, e.g., more recent answers are worth more points

### Adding a new game mode:
- Create a new game mode that focuses on relationships between classes, e.g., "Class Relations"
- Use a different set of questions and challenges that test users' understanding of relationships between classes
- Allow users to earn points and badges in this new game mode

### Optimizing semantic similarity score calculation:
- Use a more efficient algorithm/library to calculate the semantic similarity score
- When the user enter its own definition, instead of comparing its definition with all the existing definition to find the closest one, just compare to the top5 scored definitions and find the closest one among those

# Docker deployment
This application can de dockerized also.

### Explanation

* `FROM python:3.9-slim`: This line tells Docker to use the official Python 3.9 image as a base image.
* `WORKDIR /app`: This line sets the working directory in the container to `/app`.
* `COPY requirements.txt .`: This line copies the `requirements.txt` file from the current directory into the container.
* `RUN pip install -r requirements.txt`: This line installs the dependencies specified in `requirements.txt` using pip.
* `COPY . .`: This line copies the application code from the current directory into the container.
* `EXPOSE 8000`: This line exposes port 8000 from the container to the host machine.
* `CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8000"]`: This line sets the default command to run when the container starts. In this case, it runs the Gunicorn server with the `app` application object, binding to all available network interfaces (`0.0.0.0`) on port 8000.

### Deploying the Container

To deploy the container, you can use the following command:

`docker build -t ontoquest .`

`docker run -p 8000:8000 ontoquest`

### Removing the Deployment of the container
Stop the container: `docker stop <container_name>`

Remove the container: `docker rm <container_name>`

# Kubernetes pods deployment
As we have generated a docker image for the application and the database is decentralised, we can deploy the application in a replica-set mo using kubernetes and pods from the docker image we have.
### Explanation

* `apiVersion` and `kind`: These lines specify the API version and kind of the deployment.
* `metadata`: This section specifies metadata about the deployment, such as its name.
* `spec`: This section specifies the desired state of the deployment.
* `replicas`: This line specifies the number of replicas (i.e., copies) of the container to run.
* `selector`: This section specifies the label selector for the deployment.
* `template`: This section specifies the template for the deployment.
* `metadata`: This section specifies metadata about the template.
* `spec`: This section specifies the desired state of the template.
* `containers`: This section specifies the containers to run in the deployment.
* `name`: This line specifies the name of the container.
* `image`: This line specifies the container image to use.
* `ports`: This section specifies the ports to expose from the container.

### Deploying the Manifest

To deploy the manifest, you can use the following command:

`kubectl apply -f manifest.yaml`

This will create a deployment in your Kubernetes cluster using the configuration specified in the `manifest.yaml` file.

### Removing the Deployment

To remove the deployment, you can use the following command:

`kubectl delete deployment ontoquest`

This will delete the deployment and its associated resources.

### Change between clusters in Kubectl ###
First get all the available clusters in kubernetes. 

`kubectl config get-contexts`

Change between them.

`kubectl config use-context docker-desktop `