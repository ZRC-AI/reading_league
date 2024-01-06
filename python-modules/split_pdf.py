
import PyPDF2
from io import BytesIO

def split_pdf_pages(pdf_bytes):
    pdf_file = BytesIO(pdf_bytes)
    pdf_reader = PyPDF2.PdfFileReader(pdf_file)

    page_bytes_list = []

    for page_num in range(pdf_reader.getNumPages()):
        pdf_writer = PyPDF2.PdfFileWriter()
        pdf_writer.addPage(pdf_reader.getPage(page_num))

        output_pdf = BytesIO()
        pdf_writer.write(output_pdf)
        page_bytes_list.append(output_pdf.getvalue())

    return page_bytes_list

# 示例用法
input_pdf_bytes = b"Your PDF binary data here"
page_bytes_list = split_pdf_pages(input_pdf_bytes)

# page_bytes_list 中包含了分割后的每一页的UInt8List
