import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ExtractTextFromPdf{

static  Future<String> extractTextFromPDF() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(result!= null) {
      print(result.files.first.name);

      final file = File(result.files.first.path!);

      // Read the bytes
      final bytes = await file.readAsBytes();

      print(file);
      // file == OpenAppFile.open(file.path.toString());

      PdfDocument document = PdfDocument(inputBytes: bytes);
      //Create PDF text extractor to extract text.

      PdfTextExtractor extractor = PdfTextExtractor(document);

      //Extract text.
      String text = extractor.extractText();
      if(text!= '') {
        print('text is read');
      }
      else
        print("Nothing is read");
      // Dispose the document.
      document.dispose();
      return text;
      //Save the file and launch/download.
      //   SaveFile.saveAndLaunchFile(text, 'output.txt');
    }
    else
      return "unsuccessful";
  }
}