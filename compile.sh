mkdir -p ./nunavut_out

# Build Docker image
echo "Building Docker image..."
docker build -t kiwibot-dsdl-test .

# DSDL compilation configuration
compile_dsdl_cmd="nnvg \
    --target-language c \
    --outdir /app/output \
    -I ./public_regulated_data_types/uavcan \
    /app/dsdl_input \
    --allow-unregulated-fixed-port-id"

DSDL_INPUT_DIR="./kiwibot/test" # Define input directory with .uavcan/.dsdl files to compile
COMPILED_OUTPUT_DIR="./nunavut_out" # Define output directory to save compiled files

# Get current user's UID and GID
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# Run compilation cmd inside docker container with user permissions
if docker run \
    --user ${USER_ID}:${GROUP_ID} \
    -v ${COMPILED_OUTPUT_DIR}:/app/output \
    -v ${DSDL_INPUT_DIR}:/app/dsdl_input \
    kiwibot-dsdl-test $compile_dsdl_cmd; then
    echo "Compilation complete. Output files saved in ${COMPILED_OUTPUT_DIR}"
else
    echo "Error: Docker compilation failed"
    exit 1
fi