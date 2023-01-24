#!/bin/bash

set -euxo pipefail

package_dir="$PROJECT_NAME-$PLATFORM"

mkdir $package_dir

unzip -q $PROJECT_NAME-$PLATFORM-$VERSION.zip

"$package_dir/pharo/bin/pharo" --headless $package_dir/image/$PROJECT_NAME.image eval "| response contents text timestamp |
    response := ZnClient new
                    url:
                        'https://api.github.com/repos/openponk/$REPOSITORY_NAME/releases/tags/nightly';
                    accept: ZnMimeType applicationJson;
                    setBearerAuthentication:
                        '$GITHUB_TOKEN';
                    get.

    contents := STONJSON fromString: response.

    text := String streamContents: [ :s |
        s << 'name,created_at,download_count'.
        s lf.
        (contents at: #assets) do: [ :each | 
            s << (each at: #name) asString << ',' 
            << (each at: #created_at) asString << ',' 
            << (each at: #download_count) asString.
        s lf ]
    ].

    timestamp := DateAndTime now asString.

    ZnClient new
        url:
            'https://api.github.com/repos/openponk/$REPOSITORY_NAME/contents/'
            , timestamp , '.csv';
        accept: ZnMimeType applicationJson;
        setBearerAuthentication: '$GITHUB_TOKEN';
        entity: (ZnEntity
                 with: '{
    \"content\":\"' , text asByteArray base64Encoded , '\",
    \"message\":\"' , timestamp , '\",
    \"branch\":\"dls\"  
}'
                 type: ZnMimeType applicationJson);
        put"

