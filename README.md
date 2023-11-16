# kiwibot_dsdl
Public unregulated vendor-specific UAVCAN DSDL definitions


# UAVCAN DSDL Compilation with Nunavut

This README provides guidance on how to create a new UAVCAN message and compile it using Nunavut.

## Prerequisites

- Python installed on your system
- Nunavut installed (you can install it using `pip install nunavut`)
- Clone or download the UAVCAN public regulated data types from [here](https://github.com/UAVCAN/public_regulated_data_types)

## Creating a New Message

1. **Create a New DSDL File**: Create a new `.uavcan` DSDL file in your project's `dsdl` directory. For example, `my_message.1.0.uavcan`.

2. **Define Your Message**: Open the file in a text editor and define your message. Follow the UAVCAN specification for DSDL. An example message definition might look like:

    `uint8 MY_CONSTANT = 42`
`uint32 value`
`uint32 result`


3. **Save Your File**: Save the changes to your DSDL file.

## Compiling the Message

1. **Open Command Line**: Open your command line interface.

2. **Navigate to Your Project Directory**: Use the `cd` command to navigate to your project directory.

3. **Check Nunavut version**: The current supported version is `0.4.0`, you can find the exe in `nnvg.zip` 
   
4. **Run Nunavut**: Compile your DSDL file using the following command:

```bash
nnvg --target-language c --outdir .\nunavut_out\ -I [PATH TO public_regulated_data_types\uavcan] .\kiwibot --allow-unregulated-fixed-port-id
```

Replace `[PATH TO public_regulated_data_types\uavcan]` with the path to your UAVCAN public regulated data types directory.
Replace `.\kiwibot` with the path to your project's DSDL directory.
Check for Output: After running the command, check the `.\nunavut_out directory` for the generated source files.


## Integration
Integrate the generated source code into your project.
Ensure that your project's build system includes the generated files.

## Troubleshooting
If you encounter errors, verify the syntax of your DSDL file and the paths in your Nunavut command.
Ensure all dependencies and standard DSDL definitions are correctly referenced.
For more information, refer to the UAVCAN specification and the Nunavut documentation.
