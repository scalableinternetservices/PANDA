import React, { useEffect, useState } from 'react';

function Posts(props) {
  return (
    <div>
    {
      props.posts.map((postItem) =>
        <div key={postItem.id}>
          <h2>Title: {postItem.title}</h2>
          <p>{postItem.body}</p>
          <div>Point To View: {postItem.points2view}</div>
          <div> Created At: {new Date(postItem["created_at"]).toLocaleString()}</div>
        </div>
      )
    }
    </div>
  )
}

export default Posts