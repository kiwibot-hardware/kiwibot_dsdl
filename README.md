# kiwibot_dsdl
Public unregulated vendor-specific UAVCAN DSDL definitions


# UAVCAN DSDL Compilation with Nunavut

This README provides guidance on how to create a new UAVCAN message and compile it using Nunavut via Docker.

## Prerequisites

- Docker Engine installed on your system

## Creating a New Message

1. **Create a New DSDL File**: Create a new `.uavcan` DSDL file in your project's `dsdl` directory. For example, `my_message.1.0.uavcan`.

2. **Define Your Message**: Open the file in a text editor and define your message. Follow the UAVCAN specification for DSDL. An example message definition might look like:

    `uint8 MY_CONSTANT = 42`
    `uint32 value`
    `uint32 result`

3. **Save Your File**: Save the changes to your DSDL file.

## Compiling the Message

1. **Configure Input Variables**: Open `compile.sh` and modify these variables according to your setup:
   ```bash
   DSDL_INPUT_DIR="./path/to/your/dsdl/directory"  # Path to your .uavcan/.dsdl files
   DSDL_OUTPUT_DIR="./nunavut_out"            # Where generated files will be saved
   ```

2. **Run the Compilation Script**: Execute the compilation script:
   ```bash
   ./compile.sh
   ```

3. **Check Results**: If compilation is successful, you'll see a message indicating where the output files are saved. If there's an error, the script will exit with an error message.

## Output
- Generated files will be placed in the directory specified by `DSDL_OUTPUT_DIR`
- The script will confirm successful compilation with a message showing the output location

## Integration
Integrate the generated source code into your project.
Ensure that your project's build system includes the generated files.

## Troubleshooting
- Ensure Docker Engine is running
- Verify the paths in `DSDL_INPUT_DIR` and `DSDL_OUTPUT_DIR` are correct
- Check that your DSDL file follows the UAVCAN specification
- If you encounter errors, verify the syntax of your DSDL file and the paths in the `compile.sh` script.

For more information, refer to the UAVCAN specification and the Nunavut documentation.

## Common Errors and Solutions

### Missing Serialization Mode Error
If you encounter an error like this:

```MissingSerializationModeError: Either @sealed or @extent ... are required```

**Solution**: Add the following line at the end of your DSDL file:

```
... {your dsdl file content} ...

@extent 64 * 8
```

**Why this works**: 
- In UAVCAN, every message type must declare its serialization mode
- `@extent` defines the maximum allowed serialized length of the message in bits
- `64 * 8` means 64 bytes (512 bits), which is typically sufficient for most messages
- This helps ensure wire compatibility and prevents undefined behavior in message serialization
- Alternative to `@extent` is `@sealed`, which makes the message type immutable but less flexible for future changes
