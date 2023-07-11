import xml.etree.cElementTree as ET


def search_tag_inXML(xml_file,tag_list):
    result_list = []
    tree = ET.parse(xml_file)
    root = tree.getroot()
    print(len(root))

    for exp_pack in root :
        try :
            study_abstract = exp_pack.find("STUDY/DESCRIPTOR/STUDY_ABSTRACT").text
            print(study_abstract)
        except :
            continue
        for t in tag_list :
            if(t in study_abstract):
                access_id = exp_pack.find("EXPERIMENT").attrib
                result_list.append(access_id["accession"])
                break
    return result_list

if __name__ == '__main__':
    tag_list = {"embryo","embryos","embryon","trophoblast","pluripotent"}
    xml_file_name = '1.xml'
    result = search_tag_inXML(xml_file_name, tag_list)
    print(len(result))
    print(result)
