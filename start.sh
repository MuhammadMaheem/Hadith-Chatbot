#!/bin/bash

# Hadith Chatbot - Quick Start Script
# This script sets up and runs the Flask application

echo "🕌 Hadith Chatbot - Starting Application..."
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
    echo "✓ Virtual environment created"
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install/Update dependencies
echo "📥 Installing dependencies..."
pip install -r requirements.txt --quiet

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "⚠️  Warning: .env file not found!"
    echo "Please create a .env file with your GROQ_API_KEY"
    echo "Example:"
    echo "GROQ_API_KEY=your_key_here"
    echo ""
    read -p "Press Enter to continue anyway or Ctrl+C to exit..."
fi

# Check if required data files exist
echo "🔍 Checking required data files..."
required_files=("english_embeddings.npy" "arabic_embeddings.npy" "hadith_faiss_en.index" "hadith_faiss_ar.index")
missing_files=0

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing: $file"
        missing_files=$((missing_files + 1))
    else
        echo "✓ Found: $file"
    fi
done

if [ $missing_files -gt 0 ]; then
    echo ""
    echo "⚠️  Warning: $missing_files required data file(s) missing!"
    echo "Please ensure all embedding and index files are present."
    echo ""
    read -p "Press Enter to continue anyway or Ctrl+C to exit..."
fi

# Start the Flask application
echo ""
echo "🚀 Starting Flask application..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📍 Application will be available at:"
echo "   http://localhost:5000"
echo "   http://127.0.0.1:5000"
echo ""
echo "Press Ctrl+C to stop the server"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

python app.py
