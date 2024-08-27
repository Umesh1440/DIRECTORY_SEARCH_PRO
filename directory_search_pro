#!/bin/bash

# Add a large ASCII banner for "Directory Search Pro"
echo "###########################################################"
echo "##                                                       ##"
echo "##          DIRECTORY SEARCH PRO - 10X ENHANCED          ##"
echo "##                                                       ##"
echo "###########################################################"
echo "##                   Made by Umesh Sharma                ##"
echo "###########################################################"
echo ""
echo "About: This tool is designed to perform directory search and subdomain enumeration."
echo "It allows you to scan a single domain or multiple domains from a file, and it identifies live HTTPS domains."
echo ""

# Function to display usage information
usage() {
    echo "Usage: $0 [-u <single domain>] [-f <file with domains>] [-h]"
    echo ""
    echo "Options:"
    echo "  -u <single domain>    : Scan a single domain."
    echo "  -f <file with domains>: Scan multiple domains listed in a file."
    echo "  -h, --help            : Display this help message and exit."
    echo ""
    echo "Example:"
    echo "  $0 -u example.com      : Scans the domain 'example.com'."
    echo "  $0 -f domains.txt      : Scans all domains listed in 'domains.txt'."
    exit 1
}

# Check if required tools are installed
check_tool_installed() {
    local tool="$1"
    if ! command -v "$tool" &> /dev/null; then
        echo "$tool could not be found. Please install it first."
        exit 1
    fi
}

# Checking all tools
check_tool_installed "subfinder"
check_tool_installed "assetfinder"
check_tool_installed "httpx"
check_tool_installed "dirsearch"

# Initialize variables
DOMAINS_FILE=""
SINGLE_DOMAIN=""

# Parse command-line arguments
while getopts "u:f:h" opt; do
    case ${opt} in
        u)
            SINGLE_DOMAIN="$OPTARG"
            ;;
        f)
            DOMAINS_FILE="$OPTARG"
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done

# Function to sanitize filenames by replacing or removing invalid characters
sanitize_filename() {
    local filename="$1"
    echo "$filename" | sed 's|[/:]|_|g'
}

# Output directory for dirsearch results
OUTPUT_DIR="dirsearch_results"
mkdir -p "$OUTPUT_DIR"

# Function for subdomain enumeration and further processing
process_domain() {
    local domain="$1"
    local sanitized_domain=$(sanitize_filename "$domain")
    mkdir -p "$sanitized_domain"
    cd "$sanitized_domain" || exit

    # Step 1: Subdomain Enumeration
    echo "Subdomain Enumeration Started for $domain"
    subfinder -d "$domain" | tee -a "subfinder-$sanitized_domain.txt"
    assetfinder "$domain" | tee -a "assetfinder-$sanitized_domain.txt"
    echo "Subdomain Enumeration Finished for $domain"

    # Step 2: Finding Unique Domains
    echo "Finding Unique Domains..."
    cat "subfinder-$sanitized_domain.txt" "assetfinder-$sanitized_domain.txt" | sort -u | tee -a "unique-domains-$sanitized_domain.txt"
    echo "Unique Domains Saved"

    # Step 3: Checking For Live Domains with HTTPS
    echo "Checking For Live Domains with HTTPS..."
    cat "unique-domains-$sanitized_domain.txt" | httpx -silent -ports 443 | tee -a "live-domains-$sanitized_domain.txt"
    echo "Live Domains Saved"

    # Step 4: Directory Search for Live Domains
    echo "Running Directory Search on Live Domains..."
    while IFS= read -r live_domain; do
        local sanitized_live_domain=$(sanitize_filename "$live_domain")
        echo "Running dirsearch for https://$live_domain"
        check_indexing "$live_domain"
    done < "live-domains-$sanitized_domain.txt"
    echo "Directory Search Completed"

    cd ..
}

# Function to check directory indexing
check_indexing() {
    local domain="$1"
    local sanitized_domain=$(sanitize_filename "$domain")
    local output_file="$OUTPUT_DIR/${sanitized_domain}.txt"
    
    echo "Checking directory indexing for $domain..."
    dirsearch -u "https://$domain" -e * -t 20 --timeout=10 -o "$output_file"
}

# Main logic to handle options
if [[ -n "$SINGLE_DOMAIN" ]]; then
    # If a single domain is specified
    process_domain "$SINGLE_DOMAIN"
elif [[ -n "$DOMAINS_FILE" ]]; then
    # If a file with domains is specified
    if [[ ! -f "$DOMAINS_FILE" ]]; then
        echo "Domains file '$DOMAINS_FILE' not found."
        exit 1
    fi
    while IFS= read -r domain; do
        process_domain "$domain"
    done < "$DOMAINS_FILE"
else
    usage
fi

echo "Process completed. Check results in respective directories."
