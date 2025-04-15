# GoChat Project Documentation

## Project Overview

GoChat is a Go board game application where users can play against an AI opponent that communicates conversationally. The AI not only plays the game but engages in natural language conversation.

## Technology Stack

### Frontend
- **Languages/Technologies**: HTML, CSS, Vanilla JavaScript
- **Key Components**:
  - HTML Canvas for Go board rendering
  - Client-side move validation
### Backend
- **Framework**: FastAPI (Python)
- **Database**: PostgreSQL
- **AI Integration**:
  - LangChain for LLM integration
  - LangGraph for agent workflow
  - Claude API as the LLM provider

### Infrastructure
- **Development**: Docker containers (PostgreSQL)
- **Deployment Options**:
  - Oracle Cloud VM (12GB RAM, 100GB storage)
  - Alternative: Google Cloud Platform serverless

## System Architecture

### Component Diagram

```
┌─────────────────┐     ┌───────────────────────────┐     ┌───────────────┐
│                 │     │                           │     │               │
│    Frontend     │◄────►       FastAPI Backend     │◄────►   PostgreSQL  │
│  (HTML/JS/CSS)  │     │                           │     │   Database    │
│                 │     │                           │     │               │
└─────────────────┘     └───────────────┬───────────┘     └───────────────┘
                                        │
                                        ▼
                             ┌─────────────────────┐
                             │                     │
                             │    LLM Integration  │
                             │  (LangChain/Graph)  │
                             │                     │
                             └─────────────────────┘
```

### Data Flow

1. Player makes a move on the frontend
2. Frontend validates move according to Go rules
3. Valid move sent to backend
4. Backend updates game state in database
5. AI agent (LangGraph workflow) processes the current game state
6. AI determines next move and generates conversational response
7. Backend sends AI move and message back to frontend
8. Frontend updates the board and displays the message

## Database Schema

### Game Sessions Table


### Moves Table


### Messages Table


## API Endpoints


## AI Agent Design

The AI opponent will use a LangGraph workflow to:

1. **Perception**: Process and understand the current Go board state
2. **Strategy**: Evaluate possible moves and select the optimal one
3. **Communication**: Generate natural language explanations and responses


## Deployment Strategy

Preferred approach: Full containerized deployment to Oracle Cloud VM
1. Frontend and backend containerized with Docker
2. PostgreSQL database in Docker container
3. Nginx as reverse proxy with SSL
4. Optional: CDN integration via Cloudflare for static assets

Alternative approaches:
- Hybrid (Frontend on Cloudflare/GitHub Pages, Backend on VM)
- Fully serverless (GCP Cloud Run + Cloud SQL)
