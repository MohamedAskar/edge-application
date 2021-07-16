import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/models/item.dart';
import 'package:edge/provider/color_picker.dart';
import 'package:edge/screens/admin_screen.dart';
import 'package:edge/widgets/edge_appbar.dart';
import 'package:edge/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:ionicons/ionicons.dart';

class EditItemScreen extends StatefulWidget {
  static const routeName = '/edit-item-screen';

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  // Future<String> uploadImage(File file, String folderName) async {
  //   FirebaseStorage firebaseStorage =
  //       FirebaseStorage(storageBucket: 'gs://store-ef99f.appspot.com');
  //   StorageReference reference = firebaseStorage
  //       .ref()
  //       .child('shoes/$folderName/${path.basename(file.path)}');
  //   StorageUploadTask storageUploadTask = reference.putFile(file);
  //   StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
  //   String url = await taskSnapshot.ref.getDownloadURL();
  //   return url;
  // }
  final List<String> categories = ['Men', 'Woman'];

  Item _editedItem = Item(
    id: null,
    name: '',
    price: 0.0,
    images: [],
    category: '',
    sizes: [],
    description: '',
    avilableColors: [],
    seller: '',
    subcategory: '',
  );

  var _isInit = true;

  var edit = false;
  String category;
  List<String> menCategories = ['T-Shirt', 'Shirt', 'Jeans', 'Polo', 'Tie Dye'];
  List<String> womenCategories = [
    'T-Shirt',
    'Dress',
    'Pants',
    'Tops',
    'Tie Dye'
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final itemId = ModalRoute.of(context).settings.arguments as String;
      if (itemId != null) {
        // _editedItem = Provider.of<ItemsProvider>(context).findById(itemId);
        setState(() {
          edit = true;
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'edge.',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: ProgressHUD(
        barrierColor: Colors.transparent,
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, bottom: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add new item',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                        edit
                            ? InkWell(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                  // Provider.of<ItemsProvider>(context,
                                  //         listen: false)
                                  //     .deleteItem(_editedItem.id);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.red[400],
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[400],
                                      ),
                                    ),
                                  ],
                                ))
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(0),
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    color: Colors.white,
                    child: FormBuilder(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormBuilderTextField(
                              initialValue: !edit ? null : _editedItem.name,
                              name: 'Name',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.minLength(context, 6),
                                FormBuilderValidators.required(context),
                              ]),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 3,
                                        color: Colors.black)),
                                prefixIcon: Icon(
                                  Icons.title,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.black,
                                hintText: 'Please enter item name',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                labelText: 'Name*',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: FormBuilderTextField(
                                    initialValue: !edit
                                        ? null
                                        : _editedItem.price.toString(),
                                    name: 'Price',
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              width: 3,
                                              color: Colors.black)),
                                      prefixIcon: Icon(
                                        Icons.attach_money_outlined,
                                        color: Colors.black,
                                      ),
                                      fillColor: Colors.black,
                                      hintText: 'Please enter item price',
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      labelText: 'Price',
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Flexible(
                                  child: FormBuilderDropdown(
                                    name: 'Category',
                                    onChanged: (newValue) {
                                      setState(() {
                                        category = newValue;
                                        print(category);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              width: 3,
                                              color: Colors.black)),
                                      fillColor: Colors.black,
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      labelText: 'Category',
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    allowClear: true,
                                    hint: Text(
                                      'Select Category',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    dropdownColor: Colors.white,
                                    items: categories
                                        // ignore: non_constant_identifier_names
                                        .map((Category) => DropdownMenuItem(
                                              value: Category,
                                              child: Text(
                                                '$Category',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FormBuilderTextField(
                              initialValue: !edit ? null : _editedItem.name,
                              name: 'Image',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.url(context),
                                FormBuilderValidators.required(context),
                              ]),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 3,
                                        color: Colors.black)),
                                prefixIcon: Icon(
                                  Icons.image_outlined,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.black,
                                hintText: 'Please enter image URL',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                labelText: 'Image URL*',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FormBuilderTextField(
                              initialValue:
                                  !edit ? null : _editedItem.description,
                              name: 'Description',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              minLines: 5,
                              maxLines: 6,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 3,
                                        color: Colors.black)),
                                fillColor: Colors.black,
                                hintText: 'Enter item Description',
                                hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                labelText: 'Description',
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: FormBuilderTextField(
                                    initialValue:
                                        !edit ? null : _editedItem.name,
                                    name: 'Seller',
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.maxLength(
                                          context, 20),
                                      FormBuilderValidators.required(context),
                                    ]),
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              width: 3,
                                              color: Colors.black)),
                                      prefixIcon: Icon(
                                        Icons.branding_watermark_outlined,
                                        color: Colors.black,
                                      ),
                                      fillColor: Colors.black,
                                      hintText: 'Enter name of seller',
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      labelText: 'Seller',
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Flexible(
                                  child: FormBuilderDropdown(
                                    name: 'Category',
                                    onSaved: (newValue) {
                                      setState(() {
                                        category = newValue;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              width: 3,
                                              color: Colors.black)),
                                      fillColor: Colors.black,
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      labelText: 'SubCategory',
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    allowClear: true,
                                    hint: Text(
                                      'Select Subcategory',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    dropdownColor: Colors.white,
                                    items: (category == 'Men')
                                        ? menCategories
                                            // ignore: non_constant_identifier_names
                                            .map((Category) => DropdownMenuItem(
                                                  value: Category,
                                                  child: Text(
                                                    '$Category',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ))
                                            .toList()
                                        : womenCategories
                                            // ignore: non_constant_identifier_names
                                            .map((Category) => DropdownMenuItem(
                                                  value: Category,
                                                  child: Text(
                                                    '$Category',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ))
                                            .toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FormBuilderCheckboxGroup(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 3,
                                            color: Colors.black)),
                                    labelText: 'Available Sizes',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                name: 'AvailableSizes',
                                options: [
                                  FormBuilderFieldOption(
                                    value: 'XS',
                                    child: Text(
                                      'XS',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  FormBuilderFieldOption(
                                    value: 'S',
                                    child: Text(
                                      'S',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  FormBuilderFieldOption(
                                      value: 'M',
                                      child: Text(
                                        'M',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  FormBuilderFieldOption(
                                      value: 'L',
                                      child: Text(
                                        'L',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  FormBuilderFieldOption(
                                      value: 'XL',
                                      child: Text(
                                        'XL',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ]),
                            SizedBox(
                              height: 16,
                            ),
                            FormBuilderCheckboxGroup(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 3,
                                            color: Colors.black)),
                                    labelText: 'Available Colors',
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                name: 'Availablecolors',
                                options: [
                                  FormBuilderFieldOption(
                                      value: 'black',
                                      child: ColorWidget(color: 'black')),
                                  FormBuilderFieldOption(
                                    value: 'blanchedalmond',
                                    child: ColorWidget(color: 'blanchedalmond'),
                                  ),
                                  FormBuilderFieldOption(
                                    value: 'ghostwhite',
                                    child: ColorWidget(color: 'ghostwhite'),
                                  ),
                                  FormBuilderFieldOption(
                                      value: 'stone',
                                      child: ColorWidget(color: 'stone')),
                                  FormBuilderFieldOption(
                                      value: 'sage green',
                                      child: ColorWidget(color: 'sage green')),
                                  FormBuilderFieldOption(
                                      value: 'khaki',
                                      child: ColorWidget(color: 'khaki')),
                                  FormBuilderFieldOption(
                                      value: 'darkslateblue',
                                      child:
                                          ColorWidget(color: 'darkslateblue')),
                                  FormBuilderFieldOption(
                                      value: 'lilac',
                                      child: ColorWidget(color: 'lilac')),
                                  FormBuilderFieldOption(
                                      value: 'lightpink',
                                      child: ColorWidget(color: 'lightpink')),
                                  FormBuilderFieldOption(
                                      value: 'chrome blue',
                                      child: ColorWidget(color: 'chrome blue')),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState.saveAndValidate()) {
                          final inputValues = _formKey.currentState.value;
                          print(inputValues);

                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                child: Container(
                                  height: 700,
                                  width: size.width - 48,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Hurray!',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Your Item will be published as soon as possible',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Divider(),
                                      Center(
                                        child: ItemWidget(
                                          id: 'id',
                                          itemName: inputValues['Name'],
                                          image: inputValues['Image'],
                                          price: inputValues['Price'],
                                        ),
                                      ),
                                      Row(children: <Widget>[
                                        Text(
                                          "AVAILABLE COLORS",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: new Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20.0, right: 10.0),
                                              child: Divider(
                                                color: Colors.black,
                                                height: 36,
                                              )),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 60,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              inputValues['Availablecolors']
                                                  .length,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              width: 36,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.5,
                                                      style:
                                                          BorderStyle.solid)),
                                              child: CircleAvatar(
                                                backgroundColor: Color(
                                                    ColorPicker().hexColorToInt(
                                                        inputValues[
                                                                'Availablecolors']
                                                            [index])),
                                                radius: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(children: <Widget>[
                                        Text(
                                          "AVAILABLE SIZES",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: new Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20.0, right: 10.0),
                                              child: Divider(
                                                color: Colors.black,
                                                height: 36,
                                              )),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              inputValues['AvailableSizes']
                                                  .length,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1.5,
                                                        style:
                                                            BorderStyle.solid)),
                                                child: Center(
                                                  child: Text(
                                                    inputValues[
                                                            'AvailableSizes']
                                                        [index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Center(
                                        child: Container(
                                          width: size.width / 4,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.5)),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      transitionDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  150),
                                                      opaque: false,
                                                      pageBuilder:
                                                          (_, animation1, __) {
                                                        return SlideTransition(
                                                            position: Tween(
                                                                    begin:
                                                                        Offset(
                                                                            1.0,
                                                                            0.0),
                                                                    end: Offset(
                                                                        0.0,
                                                                        0.0))
                                                                .animate(
                                                                    animation1),
                                                            child: AdminPage());
                                                      }));
                                            },
                                            child: Center(
                                              child: Text(
                                                'Okay',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        padding: const EdgeInsets.all(16),
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            edit ? 'Update item' : 'Add item',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ColorWidget extends StatelessWidget {
  final String color;

  ColorWidget({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.black, width: 1.5, style: BorderStyle.solid)),
      child: CircleAvatar(
        backgroundColor: Color(ColorPicker().hexColorToInt(color)),
        radius: 16,
      ),
    );
  }
}
