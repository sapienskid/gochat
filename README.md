# GoChat

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

> An interactive Go board game featuring a conversational AI opponent powered by LLMs.

## Overview

GoChat combines the ancient strategy game of Go with modern AI conversation capabilities. Play against an AI opponent that not only makes moves but engages in natural dialogue about game strategy, explains its thinking, and responds to your questions - recreating the classic vibe of strategic dialogue between players.

## Features

- **Interactive Go Board**: Web-based Go board with canvas rendering
- **Conversational AI Opponent**: Powered by Claude API through LangChain
- **Client-side Validation**: Fast move validation without unnecessary server calls
- **Real-time Chat**: Natural conversation with your AI opponent
- **Game State Persistence**: Save and resume games

## Tech Stack

- **Frontend**: HTML Canvas, Vanilla JavaScript, CSS
- **Backend**: FastAPI (Python), PostgreSQL
- **AI**: LangChain, LangGraph agent workflow with Claude API
- **Infrastructure**: Docker, deployable to Oracle Cloud VM or GCP or other cloud platform. 

## Development

For detailed development information, see:
- [Project Documentation](docs/GoChat_Project_Documentation.md)
- [Project Plan](docs/Project_Plan.md)

### Quick Start

```bash
# Clone the repository
git clone https://github.com/sapienskid/gochat.git
cd gochat

# Make setup script executable
chmod +x setup.sh

# Run the setup script (creates project structure, virtual env, and installs dependencies)
./setup.sh

# Start the development server (virtual environment will be activated by the script)
cd gochat  # This is the project directory created by the setup script
uvicorn app.main:app --reload
```

### Project Structure

After running the setup script, your project will have the following structure:

```
gochat/
├── app/                  # FastAPI application
│   ├── api/              # API endpoints
│   ├── core/             # Core functionality and config
│   ├── db/               # Database models and connections
│   ├── models/           # Pydantic models
│   ├── schemas/          # Schema definitions
│   ├── ai/               # AI components
│   │   ├── README.md     # Documentation for AI module
│   │   ├── agents/       # LangGraph agent implementations
│   │   └── models/       # AI model integrations
│   └── main.py           # FastAPI application entry point
├── frontend/             # Frontend assets
│   ├── static/           # Static files
│   │   ├── css/          # Stylesheets
│   │   ├── js/           # JavaScript files
│   │   └── assets/       # Additional assets
│   │       └── images/   # Image files
│   └── templates/        # HTML templates
├── docker/               # Docker configuration
│   └── docker-compose.yml # PostgreSQL container config
├── tests/                # Test directory
├── venv/                 # Virtual environment (created by setup script)
├── .env                  # Environment variables
└── requirements.txt      # Python dependencies
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
