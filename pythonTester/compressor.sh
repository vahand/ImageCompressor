# USAGE
# ./compressor.sh [picture_path] [nb_cluster] [limite_convergence]

if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
    echo "USAGE: ./compressor.sh [picture_path] [nb_cluster] [limite_convergence]"
    exit 1
fi

picture_path="$1"
nb_cluster="$2"
limite_convergence="$3"

picture_name_with_extension=${picture_path%.*}
picture_name=${picture_name_with_extension##*/}

picture_width=$(identify -format '%w' $picture_path)
picture_height=$(identify -format '%h' $picture_path)

LIGHT_GREEN='\033[1;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "${BLUE}Generating pixels for $picture_name ...${NC}"
python3 ./gen_pixels.py $picture_path > pixels_lists/$picture_name.txt
if [ $? -ne 0 ]; then
    echo "${RED}Error while generating pixels for $picture_name${NC}"
    exit 1
else
    echo "${LIGHT_GREEN}Pixels generated for $picture_name${NC}"
fi

cd ../ && make && cd pythonTester
if [ $? -ne 0 ]; then
    echo "${RED}Error while compiling imageCompressor${NC}"
    exit 1
else
    echo "${LIGHT_GREEN}imageCompressor compiled${NC}"
fi

echo "${BLUE}Compressing $picture_name with $nb_cluster clusters and limite_convergence $limite_convergence ...${NC}"
../imageCompressor -n $nb_cluster -l $limite_convergence -f pixels_lists/$picture_name.txt > haskell_results/$picture_name\_result.txt
if [ $? -ne 0 ]; then
    echo "${RED}Error while compressing $picture_name${NC}"
    exit 1
else
    echo "${LIGHT_GREEN}Compressed $picture_name${NC}"
fi

echo "${BLUE}Generating compressed image for $picture_name ...${NC}"
python3 ./gen_picture.py haskell_results/$picture_name\_result.txt compressed_images/$picture_name\_compressed_$nb_cluster.png $picture_width $picture_height
if [ $? -ne 0 ]; then
    echo "${RED}Error while generating compressed image for $picture_name${NC}"
    exit 1
else
    echo "${LIGHT_GREEN}Compressed image generated for $picture_name${NC}"
fi