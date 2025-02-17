<h2>vivado-comparer</h2>

<h4>Usage:</h4>
<h5>Compare all IPcores with each other:</h5>
<pre><code>./VivadoComparer.sh /old/vivado/project/dir /new/vivado/project/dir</code></pre>
<h5>Compare one specified IPcore to upgraded one:</h5>
<pre><code>./VivadoComparer.sh /old/vivado/project/dir /new/vivado/project/dir specified_ip_core_name</code></pre>

<h4>Allow file to be executed propely:</h4>
<pre><code>chmod +x VivadoComparer.sh</code></pre>

<p>It's basic script, that "automates" manual proccess of finding changes in upgraded files via new version of Vivado. It is a bonus step in migration process that might save some time and make it easier to go on higher version.<p>

<p><b>Note: </b>This tool is going to be included in my future FPGA projects. It is highly recommended to clone FPGA project from source and there is no need for external tools.</p>
