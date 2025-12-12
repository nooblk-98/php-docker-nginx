<?php
/**
 * PHP Configuration Verification Script
 * This script displays current PHP settings that can be configured via environment variables
 */
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Configuration Check</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f5f5f5;
        }
        .container {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #3b82f6;
            color: white;
            font-weight: 600;
        }
        tr:hover {
            background: #f9fafb;
        }
        .value {
            font-weight: 600;
            color: #059669;
        }
        .header {
            background: #f9fafb;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        .success {
            color: #059669;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔧 PHP Configuration Status</h1>
        
        <div class="header">
            <strong>PHP Version:</strong> <span class="success"><?php echo PHP_VERSION; ?></span>
        </div>

        <h2>Runtime Configuration</h2>
        <table>
            <thead>
                <tr>
                    <th>Setting</th>
                    <th>Environment Variable</th>
                    <th>Current Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Memory Limit</td>
                    <td><code>PHP_MEMORY_LIMIT</code></td>
                    <td class="value"><?php echo ini_get('memory_limit'); ?></td>
                </tr>
                <tr>
                    <td>Upload Max Filesize</td>
                    <td><code>PHP_UPLOAD_MAX_FILESIZE</code></td>
                    <td class="value"><?php echo ini_get('upload_max_filesize'); ?></td>
                </tr>
                <tr>
                    <td>Post Max Size</td>
                    <td><code>PHP_POST_MAX_SIZE</code></td>
                    <td class="value"><?php echo ini_get('post_max_size'); ?></td>
                </tr>
                <tr>
                    <td>Max Execution Time</td>
                    <td><code>PHP_MAX_EXECUTION_TIME</code></td>
                    <td class="value"><?php echo ini_get('max_execution_time'); ?> seconds</td>
                </tr>
                <tr>
                    <td>Max Input Time</td>
                    <td><code>PHP_MAX_INPUT_TIME</code></td>
                    <td class="value"><?php echo ini_get('max_input_time'); ?> seconds</td>
                </tr>
            </tbody>
        </table>

        <h2>Environment Variables (Set)</h2>
        <table>
            <thead>
                <tr>
                    <th>Variable</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $env_vars = ['PHP_MEMORY_LIMIT', 'PHP_UPLOAD_MAX_FILESIZE', 'PHP_POST_MAX_SIZE', 'PHP_MAX_EXECUTION_TIME', 'PHP_MAX_INPUT_TIME'];
                foreach ($env_vars as $var) {
                    $value = getenv($var);
                    echo "<tr>";
                    echo "<td><code>$var</code></td>";
                    echo "<td class='value'>" . ($value ? $value : '<em>Not Set (using default)</em>') . "</td>";
                    echo "</tr>";
                }
                ?>
            </tbody>
        </table>

        <div style="margin-top: 30px; padding: 15px; background: #f0f9ff; border-left: 4px solid #3b82f6; border-radius: 4px;">
            <strong>💡 Tip:</strong> Set environment variables when running the container:<br>
            <code style="display: block; margin-top: 10px; padding: 10px; background: white; border-radius: 4px;">
                docker run -e PHP_MEMORY_LIMIT=512M -e PHP_UPLOAD_MAX_FILESIZE=250M ...
            </code>
        </div>
    </div>
</body>
</html>
