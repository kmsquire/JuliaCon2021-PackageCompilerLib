using PkgTemplates

lib_template = Template(
    dir="..",
    plugins=[
        PackageCompilerLib(lib_name="mylib")
    ]
)
lib_template("MyLib2")
