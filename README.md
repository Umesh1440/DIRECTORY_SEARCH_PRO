<h1>Directory Search Pro</h1>

<p><strong>Directory Search Pro</strong> is a comprehensive tool designed to perform directory search and subdomain enumeration. This tool can scan a single domain or multiple domains listed in a file and identify live HTTPS domains. It integrates several powerful tools for a thorough analysis and reporting.</p>

<h2>Features</h2>
<ul>
    <li><strong>Subdomain Enumeration</strong>: Uses <code>subfinder</code> and <code>assetfinder</code> to enumerate subdomains.</li>
    <li><strong>Unique Domain Identification</strong>: Identifies unique domains from the list of subdomains.</li>
    <li><strong>Live HTTPS Domain Checking</strong>: Uses <code>httpx</code> to check for live HTTPS domains.</li>
    <li><strong>Directory Search</strong>: Utilizes <code>dirsearch</code> to perform directory indexing checks on live domains.</li>
    <li><strong>Support for Single or Multiple Domain Scans</strong>: You can scan a single domain or provide a list of domains to scan.</li>
    <li><strong>Automated Setup Script</strong>: A setup script (<code>setup.sh</code>) is provided to automatically install all required tools.</li>
</ul>

<h2>Prerequisites</h2>
<ul>
    <li><strong>Operating System</strong>: Linux or macOS</li>
    <li><strong>Python</strong>: Required for <code>dirsearch</code> (Python 3 recommended)</li>
    <li><strong>Go</strong>: Required for <code>subfinder</code>, <code>assetfinder</code>, and <code>httpx</code></li>
</ul>

<h2>Installation</h2>

<h3>Step 1: Install Required Tools</h3>

<p>Run the setup script to automatically install all the necessary tools:</p>

<ol>
    <li>Make the <code>setup.sh</code> script executable:</li>
    <pre><code>chmod +x setup.sh</code></pre>
    <li>Execute the setup script:</li>
    <pre><code>./setup.sh</code></pre>
</ol>

<p>The setup script will install the following tools:</p>
<ul>
    <li><code>subfinder</code>: A subdomain enumeration tool.</li>
    <li><code>assetfinder</code>: Another subdomain enumeration tool.</li>
    <li><code>httpx</code>: A tool to check for live domains.</li>
    <li><code>dirsearch</code>: A directory searching tool.</li>
</ul>

<h3>Step 2: Verify Installation</h3>

<p>After running the <code>setup.sh</code> script, verify that the tools are installed by checking their versions:</p>
<pre><code>subfinder -version
assetfinder -h
httpx -version
python3 -m dirsearch --version</code></pre>

<h2>Usage</h2>

<p>The main script, <code>directory_search_pro.sh</code>, supports two modes:</p>

<ol>
    <li><strong>Single Domain Scan</strong>: Use the <code>-u</code> option followed by the domain name.</li>
    <li><strong>Multiple Domains Scan</strong>: Use the <code>-f</code> option followed by the filename containing a list of domains.</li>
</ol>

<h3>Command-Line Options</h3>

<ul>
    <li><code>-u &lt;single domain&gt;</code>: Scan a single domain.</li>
    <li><code>-f &lt;file with domains&gt;</code>: Scan multiple domains listed in a file.</li>
    <li><code>-h, --help</code>: Display the help message and exit.</li>
</ul>

<h3>Examples</h3>

<div class="command">
<p><strong>Scan a Single Domain</strong>:</p>
<pre><code>./directory_search_pro.sh -u example.com</code></pre>
</div>

<div class="command">
<p><strong>Scan Multiple Domains from a File</strong>:</p>
<pre><code>./directory_search_pro.sh -f domains.txt</code></pre>
</div>

<h3>Script Workflow</h3>
<ol>
    <li><strong>Subdomain Enumeration</strong>: Enumerates subdomains using <code>subfinder</code> and <code>assetfinder</code>.</li>
    <li><strong>Find Unique Domains</strong>: Extracts unique domains from the enumerated list.</li>
    <li><strong>Live Domain Checking</strong>: Checks for live domains using HTTPS with <code>httpx</code>.</li>
    <li><strong>Directory Search</strong>: Performs directory indexing checks on live domains using <code>dirsearch</code>.</li>
</ol>

<h2>Output</h2>

<p>All results are saved in dedicated directories named after the domains being processed. Each step of the scanning process saves its output in a text file for further analysis.</p>

<h2>Contributing</h2>

<p>Feel free to fork this project, submit issues, and send pull requests. Contributions are always welcome!</p>

<h2>License</h2>

<p>This project is licensed under the MIT License. See the <a href="LICENSE">LICENSE</a> file for details.</p>

<h2>Author</h2>

<p>Umesh Sharma</p>

</body>
</html>
