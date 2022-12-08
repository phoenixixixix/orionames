const add_famous_name = document.getElementById("add_famous_name")
const famous_people_fields = document.getElementById("famous_people_fields")

add_famous_name.onclick = () => {
    let newField = document.createElement("input");
    newField.setAttribute("type","text");
    newField.setAttribute("class","form-control mb-1");
    newField.setAttribute("name","name[famous_people_list_attributes][names][]");
    newField.setAttribute("id","name_famous_people_list_attributes_names_");

    famous_people_fields.appendChild(newField)
}
