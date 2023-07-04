import json
import os
directory = '/home/128jcw/i-Code/i-Code-Doc/baselines/KleisterCharity'
split = 'test'
docs_jsonl_path = directory + '/test/'+ 'document.jsonl'
docs_content_jsonl_path = directory+'/test/'+'documents_content.jsonl'
with open(docs_jsonl_path) as docs_file, open(docs_content_jsonl_path) as docs_content_file:
    for doc_line, doc_content in zip(docs_file, docs_content_file):
        doc_dict = json.loads(doc_line)
        identifier = f'{doc_dict["name"]}'
        img_dir = directory + '/png/' + identifier.split('.pdf')[0]
        if identifier.split('.pdf')[0] not in os.listdir(directory+'/png'):
            os.mkdir(img_dir)
            print(img_dir)