import json, logging, sys
from glob import glob


logger = logging.getLogger(__name__)


def read_json_file(filename):
    try:
        with open(filename, 'r') as f:
            data = json.load(f)
            logger.info(f"File loaded successfully: {filename}")
            return data
    except Exception as e:
        sys.exit(f"Error loading file: {e}")


def read_json_files(filename_pattern):
    combined_json = []
    images_data = {}
    for file in glob(f"{filename_pattern}"):
        try:
            with open(file, 'r') as f:
                data = json.load(f)
                logger.info(f"File loaded successfully: {file}")
                combined_json.append(data)
        except Exception as e:
            sys.exit(f"Error loading file: {e}")
    for data in combined_json:
        for image_data in data['metadata']['images'].values():
            images_data[image_data['dest']] = image_data['source']
    return images_data


def read_lines(filename):
    with open(filename, "r") as file:
        return [str(line.strip()) for line in file if line.strip()]


def read_multi_files(filename_pattern):
    lines = []
    for file in glob(f"{filename_pattern}"):
        for line in open (file).readlines():
            line = line.strip()
            line = line.split(' ')[0]
            if not line:
                continue
            lines.append(line)
    return lines
